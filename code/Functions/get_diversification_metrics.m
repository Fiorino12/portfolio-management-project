function [Div_ratio,entropy] = get_diversification_metrics(w,Log_Ret)
    %% Input:
    % w: vector of portfolio weights (must sum to 1).
    % Log_Ret: A matrix of asset log-returns, where each column represents the returns of an asset.

    %% Output:
    % Div_ratio: The diversification ratio of the portfolio, calculated using the `getDiversificationRatio` function.
    % entropy: The entropy of the portfolio weights, calculated using the `getEntropy` function.

    % Calculate the diversification ratio using the provided function
    Div_ratio = getDiversificationRatio(w, Log_Ret);
    
    % Calculate the entropy of the portfolio weights using the provided function
    entropy = getEntropy(w);
end