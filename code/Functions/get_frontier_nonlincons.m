function [port_returns, port_stds]=get_frontier_nonlincons(LogReturns, x0, A, b, Aeq, beq, lb, ub, wMKT, options, fun, flag)
%% Input:
    % LogReturns: Matrix of asset log-returns, where each column represents an asset.
    % x0: Initial guess for the optimization weights.
    % A, b: Matrices defining the inequality constraints (A*x ≤ b).
    % Aeq, beq: Matrices defining the equality constraints (Aeq*x = beq).
    % lb, ub: Lower and upper bounds for the weights.
    % wMKT: Market capitalization weights (not used directly in this function).
    % options: Optimization options for the `fmincon` solver.
    % fun: Nonlinear constraint function, returning c (inequalities) and Ceq (equalities).
    % flag: Structure with additional data for alternative risk model:
    %       - flag.factorLoading: Factor loadings for assets.
    %       - flag.covarFactor: Covariance matrix of the factors.
    %       - flag.D: Specific risk covariance matrix.
    %       If flag is empty, a standard covariance matrix is used.

    %% Output:
    % port_returns: Vector of portfolio returns for the efficient frontier.
    % port_stds: Vector of portfolio volatilities (standard deviations) corresponding to port_returns.

% Compute mean and covariance matrix of asset returns
avg = mean(LogReturns); 
V = cov(LogReturns); 

% Define the objective function (portfolio variance or factor model risk)
if isempty(flag)
    f = @(x) x'*V*x;
else
    f = @(x) (flag.factorLoading'*x)'*flag.covarFactor*(flag.factorLoading'*x)+x'*flag.D*x; 
end    

% Find the maximum return portfolio
w_max_exp = fmincon(@(x) -avg*x, x0, A, b, Aeq, beq, lb, ub, @(x) fun(x), options);
% Find the minimum variance portfolio
w_min_var = fmincon(@(x) f(x), x0, A, b, Aeq, beq, lb, ub, @(x) fun(x), options);

% Define range of target returns for the frontier
max_ret = avg*w_max_exp; 
min_ret = avg*w_min_var; 
N = 100;
rets = linspace(min_ret, max_ret, N); 
w = w_min_var; 
port_returns = [];
port_stds = []; 

% Iterate to compute portfolios for each target return
for ii = 1:N
    % Update equality constraints for the target return
    Aeq_new = [Aeq; avg];
    beq_new = [beq; rets(ii)];

    % Solve the optimization problem for the current target return
    w = fmincon(@(x) f(x), w, A, b, Aeq_new, beq_new, lb, ub,@(x) fun(x), options);

    % Evaluate nonlinear constraints
    [c, Ceq] = fun(w); 
    
    % Check feasibility of the solution under constraints
    if ~isempty(Ceq)
        if abs(avg*w - rets(ii)) <= 10^-4

            if Ceq <= 10^-4 
                port_returns = [port_returns; avg*w];
                port_stds = [port_stds; sqrt(f(w))];
            end

        end
    end
    if ~isempty(c)
        if (avg*w == rets(ii))

            if c <= 10^-6 
                port_returns = [port_returns; avg*w];
                port_stds = [port_stds; sqrt(f(w))];
            end

        end
    end
    
end

end