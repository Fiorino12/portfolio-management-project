% EXERCISE 7
% Expected Shortfall-modified Sharpe Ratio
display(" Exercise 7 ")

pRet = @(x) x'*LogReturns';
ConfLevel = [0.95, 0.99];
VaR_95 = @(x) quantile(pRet(x), 1-ConfLevel(1,1));
fun = @(x) (Exp_Ret*x)/sum(pRet(x).*(pRet(x) < VaR_95(x)));
x0 = rand(size(LogReturns,2),1);
x0 = x0./sum(x0);
lb = zeros(1, size(LogReturns,2))+0.001;
ub = ones(1, size(LogReturns,2));
Aeq = ones(1, size(LogReturns,2));
beq = 1;

w_Q = fmincon(fun, x0, [],[], Aeq, beq, lb, ub);
pieCharts_new(w_Q, names, Cap, "Q")
vol_Q = sqrt(w_Q'*Cov_Ret*w_Q); 
exp_Q = Exp_Ret*w_Q;

% print portoflio 
printptf('Portfolio Q',w_Q,exp_Q,vol_Q)

pRet = w_Q' * LogReturns';

VaR_95 = quantile(exp_Q, 1-ConfLevel(1,1));
%VaR_99 = quantile(exp_Q, 1-ConfLevel(1,2));
% Expected Shortfall
ES_95 = mean(pRet(pRet < VaR_95));
%ES_99 = mean(pRet(pRet < VaR_99));
