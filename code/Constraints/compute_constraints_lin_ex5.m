function [A, b, Aeq, beq, lb, ub, x0, options]=compute_constraints_lin_ex5(NumAssets, wMKT)
    %% Input:
    % NumAssets: Number of assets in the portfolio.
    % wMKT: Initial weight vector, representing market capitalization weights.

    %% Output:
    % A, b: Linear inequality constraint matrices (A * x ≤ b). 
    % Aeq, beq: Linear equality constraint matrices (Aeq * x = beq), enforcing the weights to sum to 1.
    % lb, ub: Lower and upper bounds for the portfolio weights (0 ≤ x ≤ 1).
    % x0: Initial guess for the optimization weights, adjusted from the market weights.
    % options: Options structure for the `fmincon` solver, defining algorithm and optimization settings.


    index_def=[3, 7, 9];   % indices related to the Defensive Sectors
    
    % Xo so that it respects the contrains
    x0 = wMKT;
    x0(11) = x0(11) - 0.15;
    x0(1) = x0(1) + 0.15;
    
    % cumulative defensive assets percentage < 0.3
    A = zeros(1, NumAssets);
    A(index_def) = 1;
    b = 0.3;
    
    % standard constrains
    Aeq = ones(1,NumAssets);
    beq = 1;
    lb = zeros(1,NumAssets);
    ub = ones(1,NumAssets);

    % optimization options
    options = optimoptions('fmincon', ...
        'Display', 'none', ... % no display
        'Algorithm', 'interior-point', ... % Choose an appropriate algorithm
        'MaxIterations', 10000, ...       % Increase max iterations
        'MaxFunctionEvaluations', 1e6, ...% Increase max function evaluations
        'OptimalityTolerance', 1e-8, ...  % Tighten tolerance for better results
        'StepTolerance', 1e-10);          % Allow finer steps

end