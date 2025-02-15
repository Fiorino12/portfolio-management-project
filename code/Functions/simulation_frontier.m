function [RetPtfSim, RiskPtfSim, Weights] = simulation_frontier(Exp_Ret,Cov_Ret,N_ptf,N,NumAssets,portfolio,time_horizon)
    RiskPtfSim = zeros(N_ptf, N);     % num ptf in a frontier X num of simulations
    RetPtfSim = zeros(N_ptf, N);
    Weights= zeros(N, NumAssets, 100);          %sim X assets X ptf in a frontier
    
    for n = 1:N
        % R = mvnrnd(Exp_Ret, Cov_Ret);
        % NewExpRet = R;
        % NewCov = iwishrnd(Cov_Ret, NumAssets);
        R = mvnrnd(Exp_Ret, Cov_Ret, time_horizon);
        NewExpRet = mean(R);
        NewCov = cov(R); % ! DA CHIEDERE !
    
        Psim = setAssetMoments(portfolio, NewExpRet, NewCov);
        w_sim = estimateFrontier(Psim, N_ptf);
        [pf_riskSim, pf_RetnSim] = estimatePortMoments(Psim, w_sim);
        RetPtfSim(:,n) = pf_RetnSim;
        RiskPtfSim(:, n) = pf_riskSim;
        Weights(n,:,:) = w_sim;
    end
end