function [Z_U,Z_D] = zoneArea(method1,method2,method3)
%% Load data
m1_U = [];
m2_U = [];
m3_U = [];
m1_D = [];
m2_D = [];
m3_D = [];

load(method1)
m1_U = resultsU(2:end,:);
m1_U = m1_U([m1_U{:,5}] == 1,:);
m1_D = resultsD(2:end,:);
m1_D = m1_D([m1_D{:,5}] == 1,:);

load(method2)
m2_U = resultsU(2:end,:);
m2_U = m2_U([m2_U{:,5}] == 1,:);
m2_D = resultsD(2:end,:);
m2_D = m2_D([m2_D{:,5}] == 1,:);

load(method3)
m3_U = resultsU(2:end,:);
m3_U = m3_U([m3_U{:,5}] == 1,:);
m3_D = resultsD(2:end,:);
m3_D = m3_D([m3_D{:,5}] == 1,:);

%% Activation
m1m2_U = {};
m2m3_U = {};
m1m3_U = {};
m1m2m3_U = {};
% Method 1 and method 2
for i = 1:length(m1_U)
    g1 = m1_U{i,1};
    g2 = m1_U{i,2};
    for j = 1:length(m2_U)
        if strcmp(g1,m2_U{j,1}) && strcmp(g2,m2_U{j,2})
            m1m2_U(end+1,:) = {g1,g2};
        end
    end
end

% Method 2 and method 3
for i = 1:length(m2_U)
    g1 = m2_U{i,1};
    g2 = m2_U{i,2};
    for j = 1:length(m3_U)
        if strcmp(g1,m3_U{j,1}) && strcmp(g2,m3_U{j,2})
            m2m3_U(end+1,:) = {g1,g2};
        end
    end
end

% Method 1 and method 3
for i = 1:length(m1_U)
    g1 = m1_U{i,1};
    g2 = m1_U{i,2};
    for j = 1:length(m3_U)
        if strcmp(g1,m3_U{j,1}) && strcmp(g2,m3_U{j,2})
            m1m3_U(end+1,:) = {g1,g2};
        end
    end
end

% Method 1 and method 2 and method 3
for i = 1:length(m1m2_U)
    g1 = m1m2_U{i,1};
    g2 = m1m2_U{i,2};
    for j = 1:length(m2m3_U)
        if strcmp(g1,m2m3_U{j,1}) && strcmp(g2,m2m3_U{j,2})
            m1m2m3_U(end+1,:) = {g1,g2};
        end
    end
end

a1a2a3_U = length(m1m2m3_U);
a1a2_U = length(m1m2_U)-a1a2a3_U;
a2a3_U = length(m2m3_U)-a1a2a3_U;
a1a3_U = length(m1m3_U)-a1a2a3_U;
a1_U = length(m1_U)-a1a2_U-a1a3_U-a1a2a3_U;
a2_U = length(m2_U)-a1a2_U-a2a3_U-a1a2a3_U;
a3_U = length(m3_U)-a2a3_U-a1a3_U-a1a2a3_U;

% Zone area
Z_U = [a1_U a2_U a3_U a1a2_U a1a3_U a2a3_U a1a2a3_U];

%% Repression
m1m2_D = {};
m2m3_D = {};
m1m3_D = {};
m1m2m3_D = {};
% Method 1 and method 2
for i = 1:length(m1_D)
    g1 = m1_D{i,1};
    g2 = m1_D{i,2};
    for j = 1:length(m2_D)
        if strcmp(g1,m2_D{j,1}) && strcmp(g2,m2_D{j,2})
            m1m2_D(end+1,:) = {g1,g2};
        end
    end
end

% Method 2 and method 3
for i = 1:length(m2_D)
    g1 = m2_D{i,1};
    g2 = m2_D{i,2};
    for j = 1:length(m3_D)
        if strcmp(g1,m3_D{j,1}) && strcmp(g2,m3_D{j,2})
            m2m3_D(end+1,:) = {g1,g2};
        end
    end
end

% Method 1 and method 3
for i = 1:length(m1_D)
    g1 = m1_D{i,1};
    g2 = m1_D{i,2};
    for j = 1:length(m3_D)
        if strcmp(g1,m3_D{j,1}) && strcmp(g2,m3_D{j,2})
            m1m3_D(end+1,:) = {g1,g2};
        end
    end
end

% Method 1 and method 2 and method 3
for i = 1:length(m1m2_D)
    g1 = m1m2_D{i,1};
    g2 = m1m2_D{i,2};
    for j = 1:length(m2m3_D)
        if strcmp(g1,m2m3_D{j,1}) && strcmp(g2,m2m3_D{j,2})
            m1m2m3_D(end+1,:) = {g1,g2};
        end
    end
end
a1a2a3_D = length(m1m2m3_D);
a1a2_D = length(m1m2_D)-a1a2a3_D;
a2a3_D = length(m2m3_D)-a1a2a3_D;
a1a3_D = length(m1m3_D)-a1a2a3_D;
a1_D = length(m1_D)-a1a2_D-a1a3_D-a1a2a3_D;
a2_D = length(m2_D)-a1a2_D-a2a3_D-a1a2a3_D;
a3_D = length(m3_D)-a2a3_D-a1a3_D-a1a2a3_D;


Z_D = [a1_D a2_D a3_D a1a2_D a1a3_D a2a3_D a1a2a3_D];
end
