% EXERCISE 5
% Maximum diversified and entropy portfolio
display(" Exercise 5 ")

% benchmark weights
wMKT = Cap(1:NumAssets)/sum(Cap(1:NumAssets));
[A, b, Aeq, beq, lb, ub, x0, options]=compute_constraints_lin_ex5(NumAssets, wMKT);

% get max diverrsification ratio portfolio
w_M = fmincon(@(x) -getDiversificationRatio(x, LogReturns), x0, A, b, Aeq, beq, lb, ub, @(x) non_lin_Constr(x, wMKT), options);

% get max entropy portfolio
w_N = fmincon(@(x) -getEntropy_ex5(x,LogReturns), x0, A, b, Aeq, beq, lb, ub, @(x) non_lin_Constr(x, wMKT), options);

options = optimoptions('fmincon', ...
    'Display', 'none', ...  % No display
    'Algorithm', 'sqp', ... % Choose an appropriate algorithm
    'MaxIterations', 2000, ...       % Increase max iterations
    'MaxFunctionEvaluations', 1e6, ...% Increase max function evaluations
    'OptimalityTolerance', 1e-8, ...  % Tighten tolerance for better results
    'StepTolerance', 1e-10);          % Allow finer steps

% calculate the frontier with the constrains
[port_returns, port_stds] = get_frontier_nonlincons(LogReturns, x0, A, b, Aeq, beq, lb, ub, wMKT, options, @(x) non_lin_Constr(x, wMKT), []);

vol_M = sqrt(w_M'*Cov_Ret*w_M); 
exp_M = Exp_Ret*w_M;

vol_N = sqrt(w_N'*Cov_Ret*w_N); 
exp_N = Exp_Ret*w_N;

% print portoflio 
printptf('Portfolio M',w_M,exp_M,vol_M)
printptf('Portfolio N',w_N,exp_N,vol_N)


figure()
plot_frontier(port_stds, port_returns, vol_M , exp_M, vol_N, exp_N, 'constrains ex5', 'ptf M', 'ptf N')

pieCharts_new(w_M, names, Cap, "M")
pieCharts_new(w_N, names, Cap, "N")

