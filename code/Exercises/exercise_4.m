% EXERCISE 4
% BLACK LITTERMAN
display(" Exercise 4 ")

% Compute Posterior Distribution according to the BL model
[mu_BL,cov_BL] = black_litterman(Cap,LogReturns,NumAssets,Cov_Ret,names);

% Create Black Litterman Portfolio (r distributed as a Gaussian(mu_BL,cov_BL+Cov_Ret) 
portBL = Portfolio('NumAssets', NumAssets, 'Name', 'MV with BL');
portBL = setDefaultConstraints(portBL);
portBL = setAssetMoments(portBL, mu_BL, Cov_Ret+cov_BL);
wBL=estimateFrontier(portBL,100);
[risk_BL, ret_BL] = estimatePortMoments(portBL, wBL);

% Portfolio I
w_I=wBL(:,1);
[vol_I, exp_I] = estimatePortMoments(portBL, w_I);

% Portfolio L
w_L = estimateMaxSharpeRatio(portBL);
[vol_L, exp_L] = estimatePortMoments(portBL, w_L);

% print portoflio 
printptf('Portfolio I',w_I,exp_I,vol_I)
printptf('Portfolio L',w_L,exp_L,vol_L)

% plot
figure()
plot_frontier(risk_BL,ret_BL,vol_I,exp_I,vol_L,exp_L,'Black-Litterman frontier', 'ptf I', 'ptf L')
pieCharts_new(w_I, names, Cap, "I")
pieCharts_new(w_L, names, Cap, "L")

% Compare standard,robust and Black Litterman Frontier
figure()
plot_compare_frontier([ptf_vol,robust_vol,risk_BL],[ptf_ret,robust_ret,ret_BL],'Frontier Comparison',["standard","robust","Black-Litterman"],1)


