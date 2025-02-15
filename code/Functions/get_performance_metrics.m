function [ann_ret, ann_vol, sharpe, DD, Calmar] = get_performance_metrics(w, prices)
    % Calculates key portfolio performance metrics.
    %
    % INPUT:
    %   w       - Portfolio weights for each asset.
    %   prices  - Matrix of asset prices, where rows are time points and columns are assets.
    %
    % OUTPUT:
    %   ann_ret - Annualized return of the portfolio.
    %   ann_vol - Annualized volatility of the portfolio.
    %   sharpe  - Sharpe ratio of the portfolio.
    %   DD      - Maximum drawdown of the portfolio.
    %   Calmar  - Calmar ratio of the portfolio.

    % Calculate portfolio's final and initial values
    
    X_T = prices(end, :) * (w ./prices(1,:)'); % Final portfolio value
    X_0 = 1;  % Initial portfolio value

    % Annualized return
    ann_ret = (X_T - X_0) / X_0;

    % Portfolio value over time
    x_t =  prices * (w./prices(1,:)');

    % Annualized volatility
    ann_vol = std(x_t(2:end) ./ x_t(1:end-1) - 1) * sqrt(250);

    % Sharpe ratio
    sharpe = ann_ret / ann_vol;

    % Maximum drawdown
    x_max = max(x_t); % Highest portfolio value observed
    DD = min(x_t / x_max - 1); % Minimum drawdown relative to the maximum value

    % Calmar ratio
    Calmar = ann_ret / abs(DD);
end
