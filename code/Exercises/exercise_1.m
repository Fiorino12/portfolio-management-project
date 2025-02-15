% EXERCISE 1
% PORTOFOLIO FRONTIER WITH STANDARD CONSTRAINTS
display(" Exercise 1 ")

p = Portfolio('AssetList',names);                   % Select assets
p = setDefaultConstraints(p);                       % Select standard constraints

% Compute Moments
ptf = estimateAssetMoments(p, LogReturns,'missingdata',false);

N_ptf = 100; % number of portfolio to estimate the frontier
% COMPUTE EFFICIENT FRONTIER
efficient_wgt = estimateFrontier(ptf, N_ptf);        % Estimate the weights
[ptf_vol, ptf_ret] = estimatePortMoments(ptf, efficient_wgt); % Get the risk and return.

% PORTFOLIO A
w_A = efficient_wgt(:,1);
[vol_A,exp_A] = estimatePortMoments(ptf,w_A);

% PORTFOLIO B
w_B = estimateMaxSharpeRatio(ptf);
[vol_B, exp_B] = estimatePortMoments(ptf, w_B);

% print portoflio 
printptf('Portfolio A',w_A,exp_A,vol_A)
printptf('Portfolio B',w_B,exp_B,vol_B)

% Plot
figure()
plot_frontier(ptf_vol,ptf_ret,vol_A,exp_A,vol_B,exp_B,'Portfolio frontier under standard constraints', 'ptf A', 'ptf B')
pieCharts_new(w_A, names, Cap, "A")
pieCharts_new(w_B, names, Cap, "B")

