%Michael Brunetti
%06-22-2015
%Principal Components Analysis, simple example

clear;

%Define 2 normally distributed random variables with mean = 0
x = normrnd(0,4,1,10000);
y = normrnd(0,1,1,10000);

%Rotate axes 45 degrees to make more interesting graphic
rot = [x ; y].' * [ cosd(45) sind(45); -sind(45) cosd(45) ];

x_rot = rot(:,1);
y_rot = rot(:,2);

clf;  %clear figure window
hold on; %to plot data and principal components
plot(x_rot,y_rot,'b.') %scatter plot

sigma = cov(x_rot, y_rot); %compute covariance matrix sigma

[V, lambda] = eig(sigma); %compute eigenvalues and eigenvectors of sigma

[max_e_val, max_idx] = max(lambda(:)); %find max e-val for first PC

pc_1_idx = max(max_idx - 2, 1);         %compute index of first PC
pc_2_idx = mod(max_idx,2) + 1;          %compute index of second PC

pc_1 = V(:,pc_1_idx);       %separate principal components
pc_2 = V(:,pc_2_idx);

pc_1_vec = 5.*horzcat([0;0], pc_1);  %create matrix [xvals; yvals] to plot
pc_2_vec = 5.*horzcat([0;0], pc_2);

a = plot(pc_1_vec(1,:),pc_1_vec(2,:),'g-');
b = plot(pc_2_vec(1,:),pc_2_vec(2,:),'r-');

set(a,'LineWidth',3);
set(b,'LineWidth',3);