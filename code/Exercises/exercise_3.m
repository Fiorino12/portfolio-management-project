% EXERCISE 3
% ROBUST FRONTIER
display(" Exercise 3 ")

N = 100; % simulations for resampling
time_horizon=length(LogReturns);

[RetPtfSim, RiskPtfSim, Weights] = simulation_frontier(Exp_Ret,Cov_Ret,N_ptf,N,NumAssets,p,time_horizon);
[RetPtfSim_constraints, RiskPtfSim_constraints, Weights_constraints] = simulation_frontier(Exp_Ret,Cov_Ret,N_ptf,N,NumAssets,p1,time_horizon);

%volatility and return of standard frontier
robust_vol=mean(RiskPtfSim, 2);
robust_ret=mean(RetPtfSim, 2);

%volatility and return of constraints frontier
robust_vol_constraints=mean(RiskPtfSim_constraints, 2);
robust_ret_constraints=mean(RetPtfSim_constraints, 2);

% plot simulated frontier and the respective mean frontier without and with
% constraints
figure()
plot_compare_frontier([RiskPtfSim,robust_vol],[RetPtfSim,robust_ret],'Robust Frontier',[],2)

figure()
plot_compare_frontier([RiskPtfSim_constraints,robust_vol_constraints],[RetPtfSim_constraints,robust_ret_constraints],'Robust Frontier with constraints',[],2)

% compare robust frontier standard and the ones with constraints
figure()
plot_compare_frontier([robust_vol,robust_vol_constraints],[robust_ret,robust_ret_constraints],'Robust Frontier Comparison',["standard","with constraints"],1)

% Portfolio E
[vol_E, index_E]=min(robust_vol);
exp_E = robust_ret(index_E);
w_E = mean(Weights(:,:,index_E))';

% Portfolio G
sharpe_ratio_rob=zeros(length(robust_vol),1);

for i=1:length(robust_vol)
sharpe_ratio_rob(i)=robust_ret(i)/robust_vol(i);
end

[max_sr_G,index_G]=max(sharpe_ratio_rob);
vol_G=robust_vol(index_G);
exp_G=robust_ret(index_G);
w_G=mean(Weights(:,:,index_G))';

% print portoflio 
printptf('Portfolio E',w_E,exp_E,vol_E)
printptf('Portfolio G',w_G,exp_G,vol_G)

% plot
figure()
plot_frontier(robust_vol,robust_ret,vol_E,exp_E,vol_G,exp_G,'Portfolio robust frontier under standard constraints', 'ptf E', 'ptf G')
pieCharts_new(w_E, names, Cap, "E")
pieCharts_new(w_G, names, Cap, "G")

% Portfolio F
[vol_F, index_F]=min(robust_vol_constraints);
exp_F = robust_ret_constraints(index_F);
w_F = mean(Weights_constraints(:,:,index_F))';

% Portfolio H
sharpe_ratio_rob=zeros(length(robust_vol),1);
for i=1:length(robust_vol)
sharpe_ratio_constraints(i)=robust_ret_constraints(i)/robust_vol_constraints(i);
end
[max_sr_H,index_H]=max(sharpe_ratio_constraints);

vol_H=robust_vol_constraints(index_H);
exp_H=robust_ret_constraints(index_H);
w_H=mean(Weights_constraints(:,:,index_H))';

% print portoflio 
printptf('Portfolio F',w_F,exp_F,vol_F)
printptf('Portfolio H',w_H,exp_H,vol_H)

% plot
figure()
plot_frontier(robust_vol_constraints,robust_ret_constraints,vol_F,exp_F,vol_H,exp_H,'Portfolio robust frontier with constraints', 'ptf F', 'ptf H')
pieCharts_new(w_F, names, Cap, "F")
pieCharts_new(w_H, names, Cap, "H")

% comparison between frontier and robust frontier
figure()
plot_compare_frontier([ptf_vol,robust_vol],[ptf_ret,robust_ret],'Frontier Comparison',["standard","robust"],1)
figure()
plot_compare_frontier([ptf_vol_n,robust_vol_constraints],[ptf_ret_n,robust_ret_constraints],'Frontier Comparison with constraints',["standard","robust"],1)
