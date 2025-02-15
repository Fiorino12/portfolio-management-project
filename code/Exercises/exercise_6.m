% EXERCISE 6
% PCA
display(" Exercise 6 ")
% standardized returns

% enforcing the constrains on the standardize returns as requested, but the
% forntiers are constructed adjusting for the actual volatilities

RetStd = (LogReturns - Exp_Ret) ./ std(LogReturns); 
k = NumAssets; % Number of factors to use
[~, ~, ~, ~, explained] = pca(RetStd, 'NumComponents', k); 

cumsum(explained); % cumulated variance
k = 9; % number of factors that explain>=95% of variance

% PCA 
[factorLoading1, factorRetn, latent, ~, explained] = pca(RetStd, 'NumComponents', k); 

factorLoading = diag(std(LogReturns)) * factorLoading1; 
std_factorLoading =  factorLoading1; 

covarFactor = cov(factorRetn);
std_covarFactor = cov(factorRetn); 

% reconstruct returns both standardised and not
reconReturn = factorRetn * factorLoading' + Exp_Ret;
std_reconReturn = factorRetn * std_factorLoading' + mean(RetStd); 

% 
unexplainedRetn = LogReturns - reconReturn;
std_unexplainedRetn = RetStd - std_reconReturn; 

unexplainedCovar = diag(cov(unexplainedRetn));
std_unexplainedCovar = diag(cov(std_unexplainedRetn)); 

D = diag(unexplainedCovar);
std_D = diag(std_unexplainedCovar);

covarAsset = factorLoading * covarFactor * factorLoading' + D;

TotVar = sum(latent);
ExplainedVar = latent(1:k) / TotVar; 
n_list = 1:k; % list principoal components
CumExplainedVar = cumsum(explained(1:k)); % cumulative variance

% Plot 1: Variance explained from each component
figure;
bar(n_list, ExplainedVar);
title('Percentage of Explained Variances for each Principal Component');
xlabel('Principal Components');
ylabel('Percentage of Explained Variances');
grid on;

% Plot 2: cumulative variance
figure;
plot(n_list, CumExplainedVar, 'm', 'LineWidth', 1.5);
hold on;
scatter(n_list, CumExplainedVar, 'm', 'filled');
title('Total Percentage of Explained Variances for the first n-components');
xlabel('Number of Principal Components');
ylabel('Cumulative Percentage of Explained Variances');
grid on;

func = @(x) -(Exp_Ret*x);

[A, b, Aeq, beq, lb, ub, x0, options] = compute_constraints_lin_ex6(NumAssets, wMKT);

w_P = fmincon(@(x) func(x), x0, A, b, Aeq, beq,...
                lb, ub, @(x) non_lin_Constr_PCA(x, std_factorLoading, std_covarFactor, std_D), options); 
pieCharts_new(w_P, names, Cap, "P")
% check on constrains c<=0
[c, ceq] = non_lin_Constr_PCA(w_P, factorLoading, covarFactor, D);

%%

options = optimoptions('fmincon', ...%'Display', 'iter', ... 
    'Display','none',...
    'Algorithm', 'sqp',...% Show iteration details
    'MaxIterations', 3000, ...       % Increase max iterations
    'MaxFunctionEvaluations', 1e6,...% Increase max function evaluations
    'OptimalityTolerance', 1e-6,...  % Tighten tolerance for better results
    'StepTolerance', 1e-8); 

flag.factorLoading = factorLoading; 
flag.covarFactor = covarFactor; 
flag.D = D; 

[port_returns, port_stds] = get_frontier_nonlincons(LogReturns, x0, [], [], Aeq, beq, lb, ub, wMKT, options, @(x) non_lin_Constr_PCA(x, std_factorLoading, std_covarFactor, std_D), flag);

%%
std_pca = @(x) sqrt((factorLoading'*x)'*covarFactor*(factorLoading'*x)+x'*D*x);
vol_P = std_pca(w_P); 
exp_P = Exp_Ret*w_P; 

% print portoflio 
printptf('Portfolio P',w_P,exp_P,vol_P)


figure()
plot_frontier(port_stds, port_returns, vol_P, exp_P, port_stds(1), port_returns(1), 'PCA', 'ptf P', 'ptf min PCA var')

figure()
plot_compare_frontier([ptf_vol(1:length(port_stds)), port_stds],[ptf_ret(1:length(port_stds)),...
    port_returns], 'Frontier Comparison',["standard","PCA"],1)