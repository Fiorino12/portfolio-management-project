function e = getEntropy_ex5(x,Ret)
    %% Input:
    % x: vector of portfolio weights (must sum to 1).
    % Ret: A matrix of asset returns, where each column represents the returns of an asset.

    %% Output:
    % e: The entropy of the risk contributions (RCs) of the portfolio, computed as 
    %    -∑(p(i) * log(p(i))), where p(i) is the normalized risk contribution of asset i.

    % Compute the covariance matrix of asset returns
    V = cov(Ret);

    % Compute the portfolio volatility
    volaPtf =sqrt(x'*V*x);

    % Compute the risk contributions (RCs) of each asset
    RC = abs(x .* (V * x)) / abs(volaPtf); 

    % Normalize the risk contributions to form a "probability distribution"
    p = RC / sum(RC); 
    
    % Compute the entropy
    e = 0;
    for i = 1:length(p)
        if p(i) > 0
            e = e - p(i) * log(p(i));
        end
    end
end