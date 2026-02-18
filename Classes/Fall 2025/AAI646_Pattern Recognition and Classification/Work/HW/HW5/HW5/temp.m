%% HW5.1.2 — Problem 1 (SEED-SWEEP VERSION)
% Goal: keep increasing rng(seed) until training reaches Jmean <= 0.15
% After each seed-run, print: seed, best Jmean achieved, best errRate, and iteration where best occurred.
%
% Notes:
% - This keeps the SAME algorithm steps (SGD one-sample updates, SSE J, tanh activation, slide-54 init).
% - We stop the *seed search* when bestJmean <= thetaGoal (=0.15).
% - Inside each seed-run, we stop early if Jmean <= thetaStop (we set thetaStop = thetaGoal).

clear; close all; clc;

%% ---------------- Load data --------------------------------------------
load('hw5.mat','hw5_1','hw5_2');

%% ---------------- Build X (2x200) and T (2x200) ------------------------
X_raw = [hw5_1, hw5_2];               % 2x200
N = size(X_raw,2);

T = [repmat([ 1; -1], 1, 100), repmat([-1;  1], 1, 100)];  % 2x200
trueLab = [ones(1,100), 2*ones(1,100)];  % 1=ω1, 2=ω2 (monitor only)

%% ---------------- Standardize rows of X (slide 47) ----------------------
mu  = mean(X_raw, 2);
sig = std(X_raw, 0, 2);
sig(sig < eps) = 1;
X = (X_raw - mu) ./ sig;              % 2x200
Xb = [X; ones(1,N)];                  % 3x200 (input bias)

%% ---------------- Parameters (help doc example) -------------------------
eta   = 0.1;
Ni    = 2;
Nh    = 10;
No    = 2;

% Activation (slide 45)
a = 1.716;
b = 2/3;
f      = @(net) a * tanh(b*net);
fprime = @(net) a * b * (sech(b*net)).^2;

% Decision prototypes
t1 = [ 1; -1];
t2 = [-1;  1];

% Training loop controls
maxIter   = 1000000;   % SGD updates per seed
evalEvery = 2000;      % evaluate full J every evalEvery updates

% Seed sweep goal
thetaGoal = 0.15;      % "until theta < 0.15" interpreted as: until Jmean <= 0.15
thetaStop = thetaGoal; % early stop inside each seed-run

startSeed = 1;
maxSeeds  = 200;       % safety cap so you don't run forever

%% ---------------- 1.1 Plot dataset (raw) -------------------------------
figure('Name','Problem 1.1: Training data (raw)');
plot(hw5_1(1,:), hw5_1(2,:), 'bo','MarkerSize',5); hold on;
plot(hw5_2(1,:), hw5_2(2,:), 'r*','MarkerSize',6);
grid on; axis equal;
xlabel('x_1'); ylabel('x_2');
legend('\omega_1','\omega_2','Location','best');
title('Problem 1.1 — Training data (raw)');

%% ---------------- Seed sweep -------------------------------------------
found = false;

for seed = startSeed : (startSeed + maxSeeds - 1)

    % Train once with this seed
    result = train_one_seed(seed, Xb, T, trueLab, ...
                            Ni, Nh, No, eta, ...
                            f, fprime, t1, t2, ...
                            maxIter, evalEvery, thetaStop);

    % Print after EVERY seed-run (what you asked for)
    fprintf('SEED %3d | bestJmean=%.4f | bestErr=%.4f | bestIter=%d | converged=%d\n', ...
        seed, result.bestJmean, result.bestErrRate, result.bestIter, result.converged);

    % Stop condition for the seed sweep
    if result.bestJmean <= thetaGoal
        fprintf('\nFOUND: seed=%d reached Jmean <= %.3f (bestJmean=%.4f)\n\n', ...
            seed, thetaGoal, result.bestJmean);
        found = true;

        % Use the best weights from this seed
        W1 = result.bestW1;
        W2 = result.bestW2;
        mu_used  = mu;   %#ok<NASGU>
        sig_used = sig;  %#ok<NASGU>
        break;
    end
end

if ~found
    fprintf('\nNo seed in [%d..%d] reached Jmean <= %.3f. Increase maxSeeds or maxIter.\n\n', ...
        startSeed, startSeed+maxSeeds-1, thetaGoal);
end

%% ---------------- If found, do Problem 1.3 classification --------------
if found
    D_test_raw = [  2   3  -2   3;
                    2  -3   5  -4 ];   % 2x4

    D_test = (D_test_raw - mu) ./ sig;                 % 2x4
    D_test_b = [D_test; ones(1,size(D_test,2))];       % 3x4

    netH_t = W1 * D_test_b;                            % 10x4
    Y_t    = f(netH_t);                                % 10x4
    Yb_t   = [Y_t; ones(1,size(Y_t,2))];               % 11x4
    netO_t = W2 * Yb_t;                                % 2x4
    Z_t    = f(netO_t);                                % 2x4

    fprintf('--- Problem 1.3: Test classifications (using found seed) ---\n');
    for i = 1:size(D_test_raw,2)
        z = Z_t(:,i);
        if norm(z - t1) < norm(z - t2)
            cls = '\omega_1';
        else
            cls = '\omega_2';
        end
        fprintf('Test #%d x=[%g;%g], z=[%.4f; %.4f] => %s\n', ...
            i, D_test_raw(1,i), D_test_raw(2,i), z(1), z(2), cls);
    end
end

%% ======================= Local function =================================
function out = train_one_seed(seed, Xb, T, trueLab, Ni, Nh, No, eta, f, fprime, t1, t2, maxIter, evalEvery, thetaStop)
% Trains the network once using rng(seed), returns best-achieved Jmean and weights.

    rng(seed, 'twister');  % makes BOTH init and randi() sequence reproducible

    N = size(Xb,2);

    % Slide-54 style bounds
    wmax1 = 1/sqrt(Ni+1);   % 1/sqrt(3)
    wmax2 = 1/sqrt(Nh+1);   % 1/sqrt(11)

    % Init weights
    W1 = (2*rand(Nh, Ni+1) - 1) * wmax1;   % 10x3
    W2 = (2*rand(No, Nh+1) - 1) * wmax2;   % 2x11

    % Track best
    bestJmean = inf;
    bestErr   = inf;
    bestIter  = 0;
    bestW1    = W1;
    bestW2    = W2;
    converged = false;

    for it = 1:maxIter
        % Step 6: random single sample
        idx = randi(N);
        x = Xb(:,idx);     % 3x1
        t = T(:,idx);      % 2x1

        % Forward
        netH = W1 * x;     % 10x1
        y    = f(netH);    % 10x1
        yb   = [y; 1];     % 11x1

        netO = W2 * yb;    % 2x1
        z    = f(netO);    % 2x1

        % Backprop deltas (slides 28, 30)
        delta_k = (t - z) .* fprime(netO);                 % 2x1
        delta_j = (W2(:,1:Nh)' * delta_k) .* fprime(netH); % 10x1

        % Updates
        W2 = W2 + eta * (delta_k * yb');   % 2x11
        W1 = W1 + eta * (delta_j * x');    % 10x3

        % Evaluate full training J occasionally
        if mod(it, evalEvery) == 0
            netH_all = W1 * Xb;                    % 10xN
            Y_all    = f(netH_all);                % 10xN
            Yb_all   = [Y_all; ones(1,N)];         % 11xN
            netO_all = W2 * Yb_all;                % 2xN
            Zall     = f(netO_all);                % 2xN

            J_total = 0.5 * sum(sum((T - Zall).^2));
            Jmean   = J_total / N;

            d1 = sum((Zall - t1).^2, 1);
            d2 = sum((Zall - t2).^2, 1);
            predLab = ones(1,N);
            predLab(d2 < d1) = 2;
            errRate = mean(predLab ~= trueLab);

            % Save best snapshot
            if Jmean < bestJmean
                bestJmean = Jmean;
                bestErr   = errRate;
                bestIter  = it;
                bestW1    = W1;
                bestW2    = W2;
            end

            % Early stop if reached target
            if Jmean <= thetaStop
                converged = true;
                break;
            end
        end
    end

    out.bestJmean   = bestJmean;
    out.bestErrRate = bestErr;
    out.bestIter    = bestIter;
    out.bestW1      = bestW1;
    out.bestW2      = bestW2;
    out.converged   = converged;
end
