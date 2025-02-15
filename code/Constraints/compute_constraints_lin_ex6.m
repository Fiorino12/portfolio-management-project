function [A, b, Aeq, beq, lb, ub, x0, options] = compute_constraints_lin_ex6(NumAssets, wMKT)
    %% Input:
    % NumAssets: Number of assets in the portfolio.
    % wMKT:market capitalization portfolio weights.

    %% Output:
    % A, b: Linear inequality constraint matrices (A * x ≤ b). Empty in this case.
    % Aeq, beq: Linear equality constraint matrices (Aeq * x = beq).
    %           Enforces the weights to sum to 1.
    % lb, ub: Lower and upper bounds for the weights (0 ≤ x ≤ 1).
    % x0: Initial guess for the optimization weights, set to market weights (wMKT).
    % options: Options structure for the `fmincon` solver, defining algorithm and optimization settings.
    
    A = []; 
    b = []; 
    
    % standard constrains 
    Aeq = ones(1,NumAssets);
    beq = 1;
    lb = zeros(1,NumAssets);
    ub = ones(1,NumAssets);
    
    % Set the initial guess for weights
    x0 = wMKT;
    
    % Define optimization options
    options = optimoptions('fmincon', ...%'Display', 'iter', ...
        'Display','None', ... % no display
        'Algorithm', 'sqp',...% Show iteration details
        'MaxIterations', 2500, ...       % Increase max iterations
        'MaxFunctionEvaluations', 1e6,...% Increase max function evaluations
        'OptimalityTolerance', 1e-9,...  % Tighten tolerance for better results
        'StepTolerance', 1e-10);


end