function [c, ceq] = non_lin_Constr(x, Wmkt)
    %% Input:
    % x: portfolio weights vector (must sum to 1).
    % Wmkt: The market capitalization portfolio weights vector.

    %% Output:
    % c: Nonlinear inequality constraint, which is empty in this case (no inequality constraints).
    % ceq: Nonlinear equality constraint, ensures the sum of squared deviations of portfolio weights
    %      from market capitalization weights does not exceed 0.09.   

    % No nonlinear inequality constraints
    c = [];

    % Define the nonlinear equality constraint
    ceq = sum((x-Wmkt).^2) - 0.09;
end 