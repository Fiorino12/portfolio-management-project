function pieCharts_new(w, n, c, name)
% The function plots pie charts by company and by sector
cyc_idx = [2,4,6,10,11];
def_idx = [3,7,9];
sen_idx = [1,5,8];
left_idx = 12:16;

% Order the data
[w_cyc, ~, n_cyc] = order(w(cyc_idx), c(cyc_idx), n(cyc_idx)); %red
[w_def, ~, n_def] = order(w(def_idx), c(def_idx), n(def_idx)); %green
[w_sen, ~, n_sen] = order(w(sen_idx), c(sen_idx), n(sen_idx)); %blue
[w_left, ~, n_left] = order(w(left_idx), c(left_idx), n(left_idx)); 

tol = 7*10^-3;
other = 0;    
% not consider very low weights
idx_cyc = find(w_cyc>tol);
other = other + sum(w_cyc) - sum(w_cyc(idx_cyc)); 
w_cyc = w_cyc(idx_cyc);
n_cyc = n_cyc(idx_cyc);

idx_def = find(w_def>tol);
other = other + sum(w_def) - sum(w_def(idx_def)); 
w_def = w_def(idx_def);
n_def = n_def(idx_def);

idx_sen = find(w_sen>tol);
other = other + sum(w_sen) - sum(w_sen(idx_sen)); 
w_sen = w_sen(idx_sen);
n_sen = n_sen(idx_sen);

idx_left = find(w_left>tol);
other = other + sum(w_left) - sum(w_left(idx_left)); 
w_left = w_left(idx_left);
n_left = n_left(idx_left);

weights = [w_cyc; w_def; w_sen; w_left; other];
N = length(weights);
nm = [n_cyc; n_def; n_sen; n_left; "other"];


explode = ones(size(weights))*0;
explode(weights>=0.20) = 1; 
%explode(1:5) = 0; 
%explode((N-length(n_cyc)):N) = 2;
labels = arrayfun(@(x) sprintf('%.1f%%', x), (weights / sum(weights)) * 100, 'UniformOutput', false);

figure();
pieHandle = pie(weights, explode, labels);
patchHandles = flipud(findobj(pieHandle, 'Type', 'Patch')); % Flip to align with data order


% Color cyc (Gray with hints of Yellow) - Dark to Light
N_cyc = length(w_cyc);
shadesOfRedGray = [linspace(0.6, 0.9, N_cyc)', linspace(0.2, 0.4, N_cyc)', linspace(0.2, 0.3, N_cyc)']; % Grayish red
for ii = 1:N_cyc
    set(patchHandles(N-ii+1), 'FaceColor', shadesOfRedGray(ii, :));
end

% Color def (Gray with hints of Green) - Dark to Light
N_def = length(w_def);
shadesOfGreenGray = [linspace(0.4, 0.6, N_def)', linspace(0.6, 0.8, N_def)', linspace(0.4, 0.6, N_def)']; % Grayish green
for ii = 1:N_def
    set(patchHandles(N - N_cyc - ii + 1), 'FaceColor', shadesOfGreenGray(ii, :));
end

% Color sen (Gray with hints of Blue) - Dark to Light
N_sen = length(w_sen);
shadesOfBlueGray = [linspace(0.4, 0.6, N_sen)', linspace(0.4, 0.6, N_sen)', linspace(0.6, 0.8, N_sen)']; % Grayish blue
for ii = 1:N_sen
    set(patchHandles(N - N_cyc - N_def - ii + 1), 'FaceColor', shadesOfBlueGray(ii, :));
end

% Color left
N_left = length(w_left);
shadesOfGray = linspace(0.4, 0.8, N_left)' * [1, 1, 1]; % Shades of gray
for ii = 1:N_left
    set(patchHandles(N - N_cyc - N_def - N_sen - ii + 1), 'FaceColor', shadesOfGray(ii, :));
end
set(patchHandles(1), 'FaceColor', [0.9, 0.9, 0.85])
% Add title and legend
title("Portfolio " + name + " Weights"); 
legend(nm, 'Location','eastoutside');
end




