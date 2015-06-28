%Michael Brunetti
%06-24-2015
%Linear Discriminant Analysis, two classes, simple example

clear;

%Define 2 classes of normally distributed random variables
x_1 = normrnd(1,4,1,10000);
y_1 = normrnd(1,1,1,10000);

x_2 = normrnd(20,1,1,10000);
y_2 = normrnd(2,2,1,10000);


rot_mat = [ cosd(45) sind(45); -sind(45) cosd(45) ];

%Rotate axes 45 degrees to make more interesting graphic
rot_1 = [x_1 ; y_1].' * rot_mat;
rot_2 = [x_2 ; y_2].' * rot_mat;

x_1 = rot_1(:,1);
y_1 = rot_1(:,2);

x_2 = rot_2(:,1);
y_2 = rot_2(:,2);

clf;  %clear figure window
hold on; %to plot data and principal components
plot(x_1,y_1,'b.',x_2,y_2,'r.') %scatter plot

%calculate mean vectors for each class
mu_1 = [ mean(x_1), mean(y_1) ];
mu_2 = [ mean(x_2), mean(y_2) ];

%define zero matricies to compute scatter
S_1 = zeros(2);
S_2 = zeros(2);

%compute within-class scatter for each class
for i = 1:10000
    S_1 = S_1 + ( [x_1(i), y_1(i)] - mu_1 ).' * ( [x_1(i), y_1(i)] - mu_1);
    S_2 = S_2 + ( [x_2(i), y_2(i)] - mu_2 ).' * ( [x_2(i), y_2(i)] - mu_2);
end

%add matricies to compute total within-class scatter
S_W = S_1 + S_2;

%subtract class means to compute between-class scatter
S_B = (mu_1 - mu_2).';

%solve matrix equation to find optimal weight vector
w = S_W \ S_B;

%enlarge weight vector to be visible on graph
w_plot = w .* -100000;

%plot weight vector
plot( [0,w_plot(1)],[0,w_plot(2)],'g','LineWidth',3 )