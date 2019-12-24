%parpool(8)

rng(0,'twister');
downlim = -1;
uplim = 1;
n = 500;

c_1 = copularnd('Gaussian',0.99999,n); %Pear = 1
c_08 = copularnd('Gaussian',0.8,n); %Pear = 0.8
c_04 = copularnd('Gaussian',0.4,n); %Pear = 0.4
c_00 = copularnd('Gaussian',0,n); %Pear = 0
c_m04 = copularnd('Gaussian',-0.4,n); %Pear = -0.4
c_m08 = copularnd('Gaussian',-0.8,n); %Pear = -0.8
c_m1 = copularnd('Gaussian',-0.99999,n); %Pear = -1

% U shape
x_u = (uplim-downlim).*rand(n,1)+downlim;
y_u = 4*(x_u.^2-1/2)+((uplim-downlim).*rand(n,1)+downlim);


% Square
x_s = (uplim-downlim).*rand(n,1)+downlim;
y_s = (uplim-downlim).*rand(n,1)+downlim;
t = [];
t_s(:,1) = x_s;
t_s(:,2) = y_s;
angle = -pi/8;
xy_s = rotate(-pi/8,t_s);

% Square 2
xy_s2 = rotate(-pi/8, xy_s);

% U shape 2
x_u2 = (uplim-downlim).*rand(n,1)+downlim;
y_u2 = 2*(x_u2.^2)+((uplim-downlim).*rand(n,1)+downlim);

% U shape 3
x_u3 = (uplim-downlim).*rand(n,1)+downlim;
y_u3 = (x_u3.^2)+((uplim-downlim).*rand(n,1)+downlim);

% Half U shape
x_u4 = abs((uplim-downlim).*rand(n,1)+downlim);
y_u4 = 4*(x_u4.^2-1/2)+((uplim-downlim).*rand(n,1)+downlim);

% Half U shape 2
x_u5 = abs((uplim-downlim).*rand(n,1)+downlim);
y_u5 = 2*(x_u5.^2)+((uplim-downlim).*rand(n,1)+downlim);

% Half U shape 3
x_u6 = abs((uplim-downlim).*rand(n,1)+downlim);
y_u6 = (x_u6.^2)+((uplim-downlim).*rand(n,1)+downlim);

% Four groups
xg1 = 0.8.*rand(n/4,1)+0.2;
xg2 = 0.8.*rand(n/4,1)-1;
xg3 = 0.8.*rand(n/4,1)+0.2;
xg4 = 0.8.*rand(n/4,1)-1;
yg1 = 0.8.*rand(n/4,1)+0.2;
yg2 = 0.8.*rand(n/4,1)-1;
yg3 = 0.8.*rand(n/4,1)+0.2;
yg4 = 0.8.*rand(n/4,1)-1;
xg5 = [xg1',xg2',xg3',xg4'];
yg5 = [yg1',yg2',yg4',yg3'];

% Circle
x = (uplim-downlim).*rand(n,1)+downlim;
y_c = cos(x*pi) + mvnrnd(0, 1/50, n);
x_c = sin(x*pi) + mvnrnd(0, 1/50, n);

fprintf('Need one minute to run ....\n')
%% Plot
figure

subplot(2,7,1)
plot_corrrelations(c_1(:,1),c_1(:,2));

subplot(2,7,2)
plot_corrrelations(c_08(:,1),c_08(:,2));

subplot(2,7,3)
plot_corrrelations(c_04(:,1),c_04(:,2));

subplot(2,7,4)
plot_corrrelations(c_00(:,1),c_00(:,2));

subplot(2,7,5)
plot_corrrelations(c_m04(:,1),c_m04(:,2));

subplot(2,7,6)
plot_corrrelations(c_m08(:,1),c_m08(:,2));

subplot(2,7,7)
plot_corrrelations(c_m1(:,1),c_m1(:,2));


subplot(2,7,8)
plot_corrrelations(x_u,y_u);

subplot(2,7,9)
plot_corrrelations(x_u2,y_u2);

subplot(2,7,10)
plot_corrrelations(x_u3,y_u3);

subplot(2,7,11)
plot_corrrelations(x_u4,y_u4);

subplot(2,7,12)
plot_corrrelations(x_u5,y_u5);

subplot(2,7,13)
plot_corrrelations(x_u6,y_u6);

% subplot(2,7,10)
% plot_corrrelations(xy_s(:,1),xy_s(:,2));
% 
% subplot(2,7,11)
% plot_corrrelations(xy_s2(:,1),xy_s2(:,2));
% 
% subplot(2,7,12)
% plot_corrrelations(xg5',yg5');
% 
% subplot(2,7,13)
% plot_corrrelations(x_c,y_c);

%% Plot function
figure_idx = 1;
function plot_corrrelations(x,y)
pear = corr(x,y);
spear = corr(x,y,'Type','Spearman');

[cgicp_s, cgicp_d] = SDC(x,y,'Pearson');
[cgics_s, cgics_d] = SDC(x,y,'Spearman');

dist = distcor(x,y,'Pearson'); %Distance

hold on
scatter(x,y,'.');
axis off
%title_p = ['Pearson: ',num2str(round(pear,1))];
%title_sp = ['Spearman: ',num2str(round(spear,1))];
%title_d = ['Distance: ',num2str(round(dist,1))];
t1 = ['P: ',num2str(round(pear,2)),'       S: ',num2str(round(spear,2)), '       D: ',num2str(round(dist,2))];
t2 = ['SDC-P: [',num2str(round(cgicp_s,2)),',',num2str(round(cgicp_d,2)),']'];
t3 = ['SDC-S: [',num2str(round(cgics_s,2)),',',num2str(round(cgics_d,2)),']'];
title({t1;t2;t3});
%title(t1)
end

%% SDC
function [sign, dependency] = SDC(x,y,type)
[d_x, d_y] = increment(x,y);


switch type
    case 'Pearson'
        sign = corr(d_x,d_y);
        dependency = distcor(x,y,'Pearson');
    case 'Spearman'
        sign = corr(d_x,d_y,'Type','Spearman');
        dependency = distcor(x,y,'Spearman');
end

end

function [d_x, d_y] = increment(x,y)
d_x = [];
d_y = [];
for i = 1:length(x)-1
    for j = i+1:length(x)
        deltaX = x(i) - x(j);
        deltaY = y(i) - y(j);
        d_x = [d_x; deltaX];
        d_y = [d_y; deltaY];
    end
end
end

function dcor = distcor(x,y,type)
% This function calculates the distance correlation between x and y.
% Reference: http://en.wikipedia.org/wiki/Distance_correlation
% Date: 18 Jan, 2013
% Author: Shen Liu (shen.liu@hotmail.com.au)
% Check if the sizes of the inputs match

if size(x,1) ~= size(y,1)
    error('Inputs must have the same number of rows')
end
% Delete rows containing unobserved values
N = any([isnan(x) isnan(y)],2);
x(N,:) = [];
y(N,:) = [];
% Calculate doubly centered distance matrices for x and y
a = pdist2(x,x);
if strcmp(type,'Spearman')
    a = rank_matrix(a); %Rank matrix
end

mcol = mean(a);
mrow = mean(a,2);
ajbar = ones(size(mrow))*mcol;
akbar = mrow*ones(size(mcol));
abar = mean(mean(a))*ones(size(a));
A = a - ajbar - akbar + abar;


b = pdist2(y,y);
if strcmp(type,'Spearman')
    b = rank_matrix(b); %Rank matrix
end

mcol = mean(b);
mrow = mean(b,2);
bjbar = ones(size(mrow))*mcol;
bkbar = mrow*ones(size(mcol));
bbar = mean(mean(b))*ones(size(b));
B = b - bjbar - bkbar + bbar;


% Calculate squared sample distance covariance and variances
dcov = sum(sum(A.*B))/(size(mrow,1)^2);
dvarx = sum(sum(A.*A))/(size(mrow,1)^2);
dvary = sum(sum(B.*B))/(size(mrow,1)^2);
% Calculate the distance correlation
dcor = sqrt(dcov/sqrt(dvarx*dvary));
end

function rank_x = rank_matrix(x)
r = sort(x(:));
rank_x = [];
for i = 1:size(x,1)
    for j = 1:size(x,2)
        idx = find(r == x(i,j));
        if length(idx) == 1
            rank_x(i,j) = idx;
        else
            rank_x(i,j) = sum(idx)/length(idx);
        end
    end
end
end