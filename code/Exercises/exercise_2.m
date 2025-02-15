% EXERCISE 2
% PORTOFOLIO FRONTIER WITH NON-STANDARD CONSTRAINTS
display(" Exercise 2 ")
  

NumAssets = length(Exp_Ret); %16
N_ptf = 100; % number of portfolio to construct the frontier

[A_ineq,b_ineq,A_eq, b_eq]=compute_constraints(NumAssets);

% construct portoflio adding constraints
p1 = Portfolio('AssetList', names);
p1 = setDefaultConstraints(p1);
p1 = addInequality(p1,A_ineq,b_ineq);
p1 = addEquality(p1,A_eq,b_eq);

% Compute Moments
ptf_n = estimateAssetMoments(p1, LogReturns,'missingdata',false);

% compute efficient frontier with constraints
efficient_wgt_n = estimateFrontier(ptf_n, N_ptf);        % Estimate the weights
[ptf_vol_n, ptf_ret_n] = estimatePortMoments(ptf_n, efficient_wgt_n); % Get the risk and return.

% Portfolio C
w_C=efficient_wgt_n(:,1);
[vol_C,exp_C] = estimatePortMoments(ptf_n, w_C);

% Portfolio D
w_D = estimateMaxSharpeRatio(ptf_n);
[vol_D, exp_D] = estimatePortMoments(ptf_n, w_D);

% print portoflio 
printptf('Portfolio C',w_C,exp_C,vol_C)
printptf('Portfolio D',w_D,exp_D,vol_D)

% Plot
figure()
plot_frontier(ptf_vol_n,ptf_ret_n,vol_C,exp_C,vol_D,exp_D,'Portfolio frontier under constraints', 'ptf C', 'ptf D')
pieCharts_new(w_C, names, Cap, "C")
pieCharts_new(w_D, names, Cap, "D")
