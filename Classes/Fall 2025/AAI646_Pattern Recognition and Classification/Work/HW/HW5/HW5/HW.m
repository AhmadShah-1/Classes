clear; close all; clc;

load('hw5.mat','hw5_1','hw5_2');
rng(2, 'twister'); 

%% 1.1 Plot Data
figure('Name','2-D training data');
plot(hw5_1(1,:), hw5_1(2,:), 'bo','MarkerSize',5); hold on;
plot(hw5_2(1,:), hw5_2(2,:), 'r*','MarkerSize',6);
grid on; axis equal;
xlabel('x_1'); ylabel('x_2');
legend('\omega_1','\omega_2','Location','best');
title('Training data (raw)');

%% 1.2 Stochastic Backpropagation
theta = 0.1;     % mean total SSE per sample
eta   = 0.1;     % step size
Ni    = 2;       % input dimension
Nh    = 10;      % hidden nodes 
No    = 2;       % output nodes


X_raw = [hw5_1, hw5_2];  % 2x200
N = size(X_raw,2);

% Target matrix
% [ 1, -1 ] for w1
% Second 100: [ -1, 1 ] for w2
T = [repmat([ 1; -1], 1, 100), repmat([-1;  1], 1, 100)];  % 2x200
trueLab = [ones(1,100), 2*ones(1,100)];

mu = mean(X_raw, 2);                  
sig = std(X_raw, 0, 2); 
X = (X_raw - mu) ./ sig;
Xb = [X; ones(1,N)]; 

% Activation function:
a = 1.716;
b = 2/3;
f      = @(net) a * tanh(b*net);
fprime = @(net) a * b * (sech(b*net)).^2;

% weights initialization
wmax1 = 1/sqrt(Ni+1);     
wmax2 = 1/sqrt(Nh+1);     
W1 = (2*rand(Nh, Ni+1) - 1) * wmax1;   
W2 = (2*rand(No, Nh+1) - 1) * wmax2;

% Training
maxIter   = 200000;  
evalEvery = 500;  

J_hist = [];
it_hist = [];

for it = 1:maxIter
    idx = randi(N);
    x = Xb(:,idx);           
    t = T(:,idx);            

    % Hidden nets and outputs
    netH = W1*x;            
    y    = f(netH);          
    yb   = [y; 1];          

    % outputs
    netO = W2*yb;            
    z    = f(netO);          

    % Sensitivities
    delta_k = (t - z) .* fprime(netO);                

    % For delta_j exclude the bias column of W2 (only weights from hidden units)
    delta_j = (W2(:,1:Nh)' * delta_k) .* fprime(netH);

    % Weight updates
    W2 = W2 + eta * (delta_k * yb');  
    W1 = W1 + eta * (delta_j * x');   

    % Compute total training error J using ALL samples
    if mod(it, evalEvery) == 0
        netH_all = W1 * Xb;                 
        Y_all = f(netH_all);             
        Yb_all = [Y_all; ones(1,N)];     
        netO_all = W2 * Yb_all;           
        Zall = f(netO_all);  
        mse = mean((T - Zall).^2, 'all');         
      
        if errRate <= theta
            fprintf('Converged: errRate=%.4f <= theta=%.3f\n', errRate, theta);
            break;
        end
    end
end

if it == maxIter
    fprintf('Reached maxIter without meeting theta.');
end

%
figure('Name','Problem 1.2: Training error');
plot(it_hist, J_hist, 'LineWidth', 1.5);
grid on;
xlabel('Iteration'); ylabel('Mean training error J/N');
title('Problem 1.2 — Stochastic backprop training error');

