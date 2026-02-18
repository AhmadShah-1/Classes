clear
%%  Problem 1 
disp('Problem 1');
load('hw3.mat');


N = size(hw3_2_1, 2);
K = 10;

% Define grid
x_range = -4:0.1:8;
y_range = -4:0.1:8;
[X, Y] = meshgrid(x_range, y_range);
[rows, cols] = size(X);

P1 = zeros(rows, cols);
P2 = zeros(rows, cols);

% KNN Function 
for i = 1:rows
for j = 1:cols
pt = [X(i,j); Y(i,j)];

% Class 1 Density
dist1 = sqrt(sum((hw3_2_1 - pt).^2, 1));
sorted_dist1 = sort(dist1);
d_k1 = sorted_dist1(K);

V1 = pi * d_k1^2;
if V1 == 0, V1 = eps; 
end 
P1(i,j) = (K/N) / V1;

% Class 2 Density 
dist2 = sqrt(sum((hw3_2_2 - pt).^2, 1));
sorted_dist2 = sort(dist2);
d_k2 = sorted_dist2(K);

V2 = pi * d_k2^2;
if V2 == 0, V2 = eps; end
P2(i,j) = (K/N) / V2;
end
end


% Plot Problem 1 Results
figure(1);
mesh(X, Y, P1);
title('Problem 1: KNN Density p(x|w1)');
xlabel('x1'); ylabel('x2'); zlabel('Density');

figure(2);
mesh(X, Y, P2);
title('Problem 1: KNN Density p(x|w2)');
xlabel('x1'); ylabel('x2'); zlabel('Density');





x_test = [1; -2];

% Class 1 test
dist_t1 = sort(sqrt(sum((hw3_2_1 - x_test).^2, 1)));
V_t1 = pi * dist_t1(K)^2;
p1_val = (K/N) / V_t1;

% Class 2 test
dist_t2 = sort(sqrt(sum((hw3_2_2 - x_test).^2, 1)));
V_t2 = pi * dist_t2(K)^2;
p2_val = (K/N) / V_t2;

disp(['p(x|w1) = ', num2str(p1_val)]);
disp(['p(x|w2) = ', num2str(p2_val)]);
if p1_val > p2_val
    disp('Classified as Class 1');
else
    disp('Classified as Class 2');
end




%% Problem 2
disp('Problem 2');
% Loading 
d1 = [2;2]*ones(1,100) + 2.*randn(2,100);
d2 = [3;3]*ones(1,100) + randn([2,100]);

for i=1:100
if d1(1,i)>0 && d1(2,i)>0
d1(1,i) = -d1(1,i);
d1(2,i) = -d1(2,i);
end
end

hw4_2_1 = d1;
hw4_2_2 = d2;



%% 2.1 Plot 2D Data
figure(3);
plot(hw4_2_1(1,:), hw4_2_1(2,:), 'ro', hw4_2_2(1,:), hw4_2_2(2,:), 'b*');
title('Problem 2.1: 2D Data');
legend('Class 1', 'Class 2');
grid on;


%% 2.2 3D Plot
xx1 = [hw4_2_1; (hw4_2_1(1,:)).*hw4_2_1(2,:)];
xx2 = [hw4_2_2; (hw4_2_2(1,:)).*hw4_2_2(2,:)];

figure(4);
plot3(xx1(1,:), xx1(2,:), xx1(3,:), 'ro', xx2(1,:), xx2(2,:), xx2(3,:), 'b*');
title('Problem 2.2: 3D Projected Data');
grid on; box on;
xlabel('x1'); ylabel('x2'); zlabel('x1*x2');





%% 2.3 Batch Perceptron
N_samples = 100;
ones_row = ones(1, N_samples);



% Y matrices
Y1 = [ones_row; xx1];      
Y2 = [ones_row; xx2];      
Y2 = -Y2;                

% Combine samples
Y_all = [Y1, Y2];          

% Initialization
a = sum(Y_all, 2);         
eta = 1;
theta = 1;
iter = 0;
max_iter = 1000;


while iter < max_iter
iter = iter + 1;

% Discriminant function
g = a' * Y_all; 
mis_indices = find(g <= 0);

if isempty(mis_indices)
disp(['Converged at iteration ', num2str(iter)]);
break;
end

% Sum of y
Y_mis = Y_all(:, mis_indices);
sum_mis = sum(Y_mis, 2);

% Update
update = eta * sum_mis;

% check magnitude
mag = sqrt(update' * update);

if mag < theta
disp(['Converged at iteration ', num2str(iter)]);
a = a + update;
break;
end

a = a + update;
end

disp('Final Weight of Vector a:');
disp(a);


save hw4.mat hw4_2_1 hw4_2_2


