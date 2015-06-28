%Michael Brunetti
%06-24-2015
%Linear Discriminant Analysis, many class example

clear;

%Define 3 classes of normally distributed random variables
x_1 = normrnd(1,4,1,10000);
y_1 = normrnd(1,1,1,10000);

x_2 = normrnd(20,1,1,10000);
y_2 = normrnd(2,2,1,10000);

x_3 = normrnd(2,2,1,10000);
y_3 = normrnd(20,1,1,10000);


rot_mat = [ cosd(45) sind(45); -sind(45) cosd(45) ];

%Rotate axes 45 degrees to make more interesting graphic
rot_1 = [x_1 ; y_1].' * rot_mat;
rot_2 = [x_2 ; y_2].' * rot_mat;
rot_3 = [x_3 ; y_3].' * rot_mat;

x_1 = rot_1(:,1);
y_1 = rot_1(:,2);

x_2 = rot_2(:,1);
y_2 = rot_2(:,2);

x_3 = rot_3(:,1);
y_3 = rot_3(:,2);

clf;  %clear figure window
hold on; %to plot data and principal components
plot(x_1,y_1,'b.',x_2,y_2,'r.',x_3,y_3,'g.') %scatter plot

mu = zeros(3,2);

%calculate mean vectors for each class
mu(1,:) = [ mean(x_1), mean(y_1) ];
mu(2,:) = [ mean(x_2), mean(y_2) ];
mu(3,:) = [ mean(x_3), mean(y_3) ];

mu_total = mean( mu ); %calculate mean across all classes

%define zero matricies to compute scatter
S_1 = zeros(2);
S_2 = zeros(2);
S_3 = zeros(2);

%compute within-class scatter for each class
for i = 1:1000
    S_1 = S_1 + ( [x_1(i), y_1(i)] - mu(1) ).' * ( [x_1(i), y_1(i)] - mu(1));
    S_2 = S_2 + ( [x_2(i), y_2(i)] - mu(2) ).' * ( [x_2(i), y_2(i)] - mu(2));
    S_3 = S_3 + ( [x_3(i), y_3(i)] - mu(3) ).' * ( [x_3(i), y_3(i)] - mu(3));
end

%add matricies to compute total within-class scatter
S_W = S_1 + S_2 + S_3;


S_B = zeros(2);

%calculate between-class scatter
for j = 1:3
    S_B = S_B + 10000 * (mu(j) - mu_total).' * (mu(j) - mu_total);
end

%solve generalized eigenvector problem for weight vectors
[W, lambda] = eig (S_W,S_B);

%enlarge weight vector to be visible on graph
W = W ./ abs(W) .* 5;

%plot weight vectors
plot([0,W(1,1)],[0,W(1,2)],'y','Linewidth',3);
plot([0,W(2,1)],[0,W(2,2)],'c','Linewidth',3);



