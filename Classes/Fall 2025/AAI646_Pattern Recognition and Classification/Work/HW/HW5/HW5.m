
clear; close all; clc;
rng(117,'twister');  
load('hw5.mat','hw5_1','hw5_2');

%% 1.1 Plot Data
figure('Name','Training data');
plot(hw5_1(1,:), hw5_1(2,:), 'bo','MarkerSize',5); hold on;
plot(hw5_2(1,:), hw5_2(2,:), 'r*','MarkerSize',6);
grid on; axis equal;
xlabel('x_1'); ylabel('x_2');
legend('\omega_1','\omega_2','Location','best');
title('Training data');



%% Build X and T
X_raw = [hw5_1, hw5_2];              
N = size(X_raw,2);
T = [repmat([ 1; -1], 1, 100), repmat([-1;  1], 1, 100)]; 
trueLab = [ones(1,100), 2*ones(1,100)];  

mu = mean(X_raw, 2);
sig = std(X_raw, 0, 2);
sig(sig < eps) = 1;         
X = (X_raw - mu) ./ sig;    
Xb = [X; ones(1,N)];

% Params
theta = 0.1;   % criterion to stop 
eta = 0.1;   % step size 
Ni = 2;     % number of input nodes
Nh = 10;    % number of hidden nodes
No = 2;     % number of output nodes

% Activation function:
a = 1.716;
b = 2/3;
f = @(net) a * tanh(b*net);
fprime = @(net) a * b * (sech(b*net)).^2;

t1 = [ 1; -1];
t2 = [-1;  1];

% weights initialization
wmax1 = 1/sqrt(Ni+1);   
wmax2 = 1/sqrt(Nh+1);   

W1 = (2*rand(Nh, Ni+1) - 1) * wmax1; 
W2 = (2*rand(No, Nh+1) - 1) * wmax2;  

% Training
maxIter = 936000;    
evalEvery = 2000;       

numChecks = floor(maxIter / evalEvery);
J_hist = nan(1, numChecks);
err_hist = nan(1, numChecks);
it_hist = nan(1, numChecks);
checkIdx = 0;

for it = 1:maxIter
    % pick a random training sample
    idx = randi(N);
    x = Xb(:,idx);     
    t = T(:,idx);      

    netH = W1 * x;     
    y = f(netH);     
    yb = [y; 1];      
    netO = W2 * yb;    
    z = f(netO);  

    delta_k = (t - z) .* fprime(netO);  
    delta_j = (W2(:,1:Nh)' * delta_k) .* fprime(netH); 
    W2 = W2 + eta * (delta_k * yb');  
    W1 = W1 + eta * (delta_j * x');   

    if mod(it, evalEvery) == 0
        netH_all = W1 * Xb;                   
        Y_all = f(netH_all);                
        Yb_all = [Y_all; ones(1,N)];         
        netO_all = W2 * Yb_all;                
        Zall = f(netO_all);                

        J_total = 0.5 * sum(sum((T - Zall).^2));  
        Jmean = J_total / N;                  

        d1 = sum((Zall - t1).^2, 1);
        d2 = sum((Zall - t2).^2, 1);
        predLab = ones(1,N);
        predLab(d2 < d1) = 2;
        errRate = mean(predLab ~= trueLab);

        checkIdx = checkIdx + 1;
        J_hist(checkIdx) = Jmean;
        err_hist(checkIdx) = errRate;
        it_hist(checkIdx) = it;

        fprintf('Iter %7d | Jmean=%.3f | errRate=%.3f\n', it, Jmean, errRate);

        % stopping condition
        if Jmean <= theta
            fprintf('Converged at iter %d: Jmean=%.4f <= theta=%.3f\n', it, Jmean, theta);
            break;
        end
    end
end

J_hist = J_hist(1:checkIdx);
err_hist = err_hist(1:checkIdx);
it_hist = it_hist(1:checkIdx);

if it == maxIter
    fprintf('Reached maxIter without meeting theta. Last Jmean=%.4f, last errRate=%.4f\n', ...
        J_hist(end), err_hist(end));
end


%% 1.3
D_test_raw = [  2  -3  -2   3;
                2  -3   5  -4 ];   

D_test = (D_test_raw - mu) ./ sig;                 % 2x4
D_test_b = [D_test; ones(1,size(D_test,2))];       % 3x4

netH_t = W1 * D_test_b;                            
Y_t = f(netH_t);                                
Yb_t = [Y_t; ones(1,size(Y_t,2))];               
netO_t = W2 * Yb_t;                                
Z_t = f(netO_t);                                

fprintf('\nTest Classifications\n');
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
