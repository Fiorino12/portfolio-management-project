function [c, ceq] = non_lin_Constr_PCA(x, factorLoading, covarFactor, D)
    %% Input:
    % x: A weight vector for the portfolio (must sum to 1).
    % factorLoading: A matrix of factor loadings for the assets.
    % covarFactor: The covariance matrix of the factors.
    % D: The specific risk covariance matrix for the assets.

    %% Output:
    % c: Nonlinear inequality constraint ensures that the portfolio's total risk (as defined by PCA)
    %    does not exceed 7% (0.07).
    % ceq: Nonlinear equality constraint, which is empty in this case (no equality constraints).

    % Define the PCA-based portfolio risk as a function of the weights
    std_pca = @(x) sqrt((factorLoading'*x)'*covarFactor*(factorLoading'*x)+x'*D*x); 

    % Define the nonlinear inequality constraint
    c = std_pca(x) - 0.75; 

    % No nonlinear equality constraints
    ceq = []; 
end 