function [mu_BL,cov_BL] = black_litterman(cap,LogReturns,NumAssets,Cov_Ret,names)
    %% Input:
    % cap: capitalization indeces
    % LogReturn: Historical log-returns of the assets
    % NumAssets: Number of Assets
    % Cov_Ret: Variance matrix of the assets
    % names: names of the assets

    %% Output:
    % mu_BL: mean of the posterior distribution
    % cov_BL: variance matrix of the posterior distributiojn

    %% Views Distribution
    v = 2;                          % Total Number of views
    tau = 1/length(LogReturns);     % Invers of the number of Observations
    P = zeros(v, NumAssets);        % Linear views  
    q = zeros(v, 1);
    Omega = zeros(v);               % Variance matrix of the likelihood distribution
    
    % View 1: 3% annual return of Energy
    P(1, 8) =1;
    q(1) = 0.03;
    
    % View 2: Momentum factor is going to outperform Quality factor by 1% 
    P(2, 15) = 1;
    P(2, 12) = -1;
    q(2) = 0.01;
    
    % Compute variance matrix of the likelihood distribution
    Omega(1,1) = tau.*P(1,:)*Cov_Ret*P(1,:)';
    Omega(2,2) = tau.*P(2,:)*Cov_Ret*P(2,:)';
    
    % from annual view to daily view
    bizyear2bizday = 1/250;
    q = q*bizyear2bizday;
    Omega = Omega*bizyear2bizday;
    
    % Plot views distribution
    X_views = mvnrnd(q, Omega, 1000);
    figure(11)
    histogram(X_views,25)
    
    %% Prior Distribution
    %The equilibrium returns are likely equal to the implied returns from the equilibrium portfolio holding. 
    %In practice, the applicable equilibrium portfolio holding can be any optimal portfolio that the investment analyst would use 
    %in the absence of additional views on the market, such as the portfolio benchmark, an index, or even the current portfolio
    
    wMKT = cap(1:NumAssets)/sum(cap(1:NumAssets));      % market capitalization weight vector of assets.
    lambda = 1.2;                                       % risk avversion coefficient
    mu_mkt = lambda.*Cov_Ret*wMKT;                      % Implied Equilibrium Return Vector
    C = tau.*Cov_Ret;                                   % Adjusted Variance Matrix
    
    % plot prior distribution
    X = mvnrnd(mu_mkt, C, 200);
    figure(12)
    histogram(X)
    
    %% Black Litterman (Posterior Distribution)
    mu_BL = inv(inv(C)+P'*inv(Omega)*P)*(P'*inv(Omega)*q + inv(C)*mu_mkt); 
    cov_BL = inv(P'*inv(Omega)*P + inv(C));
    
    % plot posterior distribution
    XBL = mvnrnd(mu_BL, cov_BL, 200);
    figure(13)
    histogram(XBL)
    
    %Prior Belief on Exp Ret vs Posterior Belief on Exp Ret
    table(names', mu_mkt*250, mu_BL*250, 'VariableNames', ["AssetNames", "Prior Belief on Exp Ret", "BL ExpREt"])

end
