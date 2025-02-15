 function DR = getDiversificationRatio(x, Ret)
    %% Input:
    % x: vector of portfolio weights (must sum to 1).
    % Ret: A matrix of asset returns, where each column represents the returns of an asset.

    %% Output:
    % DR: The diversification ratio of the portfolio, defined as the 
    %     weighted average of individual asset volatilities divided by 
    %     the portfolio volatility.
    
    % Compute the standard deviation (volatility) of each asset
    vola = std(Ret);

    % Compute the covariance matrix of asset returns
    V = cov(Ret);

    % Compute the portfolio volatility
    volaPtf =sqrt(x'*V*x);

    % Compute the diversification ratio
    DR = (x'*vola')/volaPtf;
end