% PART B
display(" Part B ")

date_first_oos=datetime('01/01/2024', 'InputFormat', 'dd/MM/yyyy');
date_last_oos=datetime('25/10/2024', 'InputFormat', 'dd/MM/yyyy');

[names,LogReturns_oos,Exp_Ret_oos,Cov_Ret_oos,Prices_oos,Dates_oos]=ImportData(filename,date_first_oos,date_last_oos);

% get performance metrics oos
ann_ret_oos = zeros(16, 1);
ann_vol_oos = zeros(16, 1);
sharpe_oos = zeros(16, 1);
DD_oos = zeros(16, 1);
Calmar_oos = zeros(16, 1);

[ann_ret_oos(1), ann_vol_oos(1), sharpe_oos(1), DD_oos(1), Calmar_oos(1)] = get_performance_metrics(wMKT, Prices_oos);
[ann_ret_oos(2), ann_vol_oos(2), sharpe_oos(2), DD_oos(2), Calmar_oos(2)] = get_performance_metrics(w_EW, Prices_oos);
[ann_ret_oos(3), ann_vol_oos(3), sharpe_oos(3), DD_oos(3), Calmar_oos(3)] = get_performance_metrics(w_A, Prices_oos);
[ann_ret_oos(4), ann_vol_oos(4), sharpe_oos(4), DD_oos(4), Calmar_oos(4)] = get_performance_metrics(w_B, Prices_oos);
[ann_ret_oos(5), ann_vol_oos(5), sharpe_oos(5), DD_oos(5), Calmar_oos(5)] = get_performance_metrics(w_C, Prices_oos);
[ann_ret_oos(6), ann_vol_oos(6), sharpe_oos(6), DD_oos(6), Calmar_oos(6)] = get_performance_metrics(w_D, Prices_oos);
[ann_ret_oos(7), ann_vol_oos(7), sharpe_oos(7), DD_oos(7), Calmar_oos(7)] = get_performance_metrics(w_E, Prices_oos);
[ann_ret_oos(8), ann_vol_oos(8), sharpe_oos(8), DD_oos(8), Calmar_oos(8)] = get_performance_metrics(w_F, Prices_oos);
[ann_ret_oos(9), ann_vol_oos(9), sharpe_oos(9), DD_oos(9), Calmar_oos(9)] = get_performance_metrics(w_G, Prices_oos);
[ann_ret_oos(10), ann_vol_oos(10), sharpe_oos(10), DD_oos(10), Calmar_oos(10)] = get_performance_metrics(w_H, Prices_oos);
[ann_ret_oos(11), ann_vol_oos(11), sharpe_oos(11), DD_oos(11), Calmar_oos(11)] = get_performance_metrics(w_I, Prices_oos);
[ann_ret_oos(12), ann_vol_oos(12), sharpe_oos(12), DD_oos(12), Calmar_oos(12)] = get_performance_metrics(w_L, Prices_oos);
[ann_ret_oos(13), ann_vol_oos(13), sharpe_oos(13), DD_oos(13), Calmar_oos(13)] = get_performance_metrics(w_M, Prices_oos);
[ann_ret_oos(14), ann_vol_oos(14), sharpe_oos(14), DD_oos(14), Calmar_oos(14)] = get_performance_metrics(w_N, Prices_oos);
[ann_ret_oos(15), ann_vol_oos(15), sharpe_oos(15), DD_oos(15), Calmar_oos(15)] = get_performance_metrics(w_P, Prices_oos);
[ann_ret_oos(16), ann_vol_oos(16), sharpe_oos(16), DD_oos(16), Calmar_oos(16)] = get_performance_metrics(w_Q, Prices_oos);

performance_table_oos = table(portfolios', ann_ret_oos, ann_vol_oos, sharpe_oos, DD_oos, Calmar_oos, ...
                          'VariableNames', ["Portfolio", "AnnualReturn", ...
                                            "AnnualVolatility", "SharpeRatio", ...
                                            "MaxDD", "Calmar"])

% get diversification metrics oos
Div_ratio_oos = zeros(16, 1);  
Entropy_oos = zeros(16, 1);   

[Div_ratio_oos(1), Entropy_oos(1)] = get_diversification_metrics(wMKT, LogReturns_oos);
[Div_ratio_oos(2), Entropy_oos(2)] = get_diversification_metrics(w_EW, LogReturns_oos);
[Div_ratio_oos(3), Entropy_oos(3)] = get_diversification_metrics(w_A, LogReturns_oos);
[Div_ratio_oos(4), Entropy_oos(4)] = get_diversification_metrics(w_B, LogReturns_oos);
[Div_ratio_oos(5), Entropy_oos(5)] = get_diversification_metrics(w_C, LogReturns_oos);
[Div_ratio_oos(6), Entropy_oos(6)] = get_diversification_metrics(w_D, LogReturns_oos);
[Div_ratio_oos(7), Entropy_oos(7)] = get_diversification_metrics(w_E, LogReturns_oos);
[Div_ratio_oos(8), Entropy_oos(8)] = get_diversification_metrics(w_F, LogReturns_oos);
[Div_ratio_oos(9), Entropy_oos(9)] = get_diversification_metrics(w_G, LogReturns_oos);
[Div_ratio_oos(10), Entropy_oos(10)] = get_diversification_metrics(w_H, LogReturns_oos);
[Div_ratio_oos(11), Entropy_oos(11)] = get_diversification_metrics(w_I, LogReturns_oos);
[Div_ratio_oos(12), Entropy_oos(12)] = get_diversification_metrics(w_L, LogReturns_oos);
[Div_ratio_oos(13), Entropy_oos(13)] = get_diversification_metrics(w_M, LogReturns_oos);
[Div_ratio_oos(14), Entropy_oos(14)] = get_diversification_metrics(w_N, LogReturns_oos);
[Div_ratio_oos(15), Entropy_oos(15)] = get_diversification_metrics(w_P, LogReturns_oos);
[Div_ratio_oos(16), Entropy_oos(16)] = get_diversification_metrics(w_Q, LogReturns_oos);

diversification_table_oos = table(portfolios', Div_ratio_oos, Entropy_oos, ...
                          'VariableNames', ["Portfolio", "DiversificationRatio", ...
                                            "Entropy"])


investment = 1;
% benchmark portfolio --> Capitalization ptf and Equally Weighted
number_of_shares_CAP = investment * wMKT ./Prices_oos(1,:)'; 
number_of_shares_EW = investment * w_EW ./Prices_oos(1,:)'; 
%  get the number of shares for each asset for each portfolio
number_of_shares_A = investment * w_A ./ Prices_oos(1,:)';
number_of_shares_B = investment * w_B ./ Prices_oos(1,:)';
number_of_shares_C = investment * w_C ./ Prices_oos(1,:)';
number_of_shares_D = investment * w_D ./ Prices_oos(1,:)';
number_of_shares_E = investment * w_E ./ Prices_oos(1,:)';
number_of_shares_F = investment * w_F ./ Prices_oos(1,:)';
number_of_shares_G = investment * w_G ./ Prices_oos(1,:)';
number_of_shares_H = investment * w_H ./ Prices_oos(1,:)';
number_of_shares_I = investment * w_I ./ Prices_oos(1,:)';
number_of_shares_L = investment * w_L ./ Prices_oos(1,:)';
number_of_shares_M = investment * w_M ./ Prices_oos(1,:)';
number_of_shares_N = investment * w_N ./ Prices_oos(1,:)';
number_of_shares_P = investment * w_P ./ Prices_oos(1,:)';
number_of_shares_Q = investment * w_Q ./ Prices_oos(1,:)';


%%
figure()
% plot the value of the portfolio during the out of sample period
plot(Dates_oos, Prices_oos * number_of_shares_CAP, 'LineWidth', 3, 'Color', [1, 0.6, 0]); 
hold on
plot(Dates_oos, Prices_oos * number_of_shares_EW, 'LineWidth', 3, 'Color', [0, 0.75, 1]); 

plot(Dates_oos, Prices_oos * number_of_shares_A, 'LineWidth', 1, 'Color', [0 0.4470 0.7410]); 
plot(Dates_oos, Prices_oos * number_of_shares_B, 'LineWidth', 1, 'Color', [0.8500 0.3250 0.0980]); 
plot(Dates_oos, Prices_oos * number_of_shares_C, 'LineWidth', 1, 'Color', [0.9290 0.6940 0.1250]); 
plot(Dates_oos, Prices_oos * number_of_shares_D, 'LineWidth', 1, 'Color', [0.4940 0.1840 0.5560]); 
plot(Dates_oos, Prices_oos * number_of_shares_E, 'LineWidth', 1, 'Color', [0.4660 0.6740 0.1880]); 
plot(Dates_oos, Prices_oos * number_of_shares_F, 'LineWidth', 1, 'Color', [0.3010 0.7450 0.9330]); 
plot(Dates_oos, Prices_oos * number_of_shares_G, 'LineWidth', 1, 'Color', [0.6350 0.0780 0.1840]); 
plot(Dates_oos, Prices_oos * number_of_shares_H, 'LineWidth', 1, 'Color', [0.5 0.5 0.5]); 
plot(Dates_oos, Prices_oos * number_of_shares_I, 'LineWidth', 1, 'Color', [0.25 0.25 0.75]); 
plot(Dates_oos, Prices_oos * number_of_shares_L, 'LineWidth', 1, 'Color', [0.75 0.25 0.25]); 
plot(Dates_oos, Prices_oos * number_of_shares_M, 'LineWidth', 1, 'Color', [0.25 0.75 0.25]); 
plot(Dates_oos, Prices_oos * number_of_shares_N, 'LineWidth', 1, 'Color', [0.75 0.75 0]); 
plot(Dates_oos, Prices_oos * number_of_shares_P, 'LineWidth', 1, 'Color', [0.4 0.6 0.8]); 
plot(Dates_oos, Prices_oos * number_of_shares_Q, 'LineWidth', 1, 'Color', [0.8 0.4 0.6]);

% Title and legend
title('Out-of-Sample Portfolios', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Date', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Value', 'FontSize', 12, 'FontWeight', 'bold');
legend({'MKT','EW','A', 'B', 'C', 'D', 'E', 'F', ...
        'G', 'H', 'I', 'L', 'M', 'N', ...
        'P', 'Q'}, ...
    'Location', 'eastoutside', 'FontSize', 8);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1, 'Box', 'on');

% Axes
xticks(linspace(Dates_oos(1), Dates_oos(end), 6)); 
xlim([Dates_oos(1), Dates_oos(end)]);
ylim([0.95 * investment, 1.4 * investment]);

% plot position
ax = gca;
ax.Position = [0.1 0.15 0.75 0.8]; 

%% Sectors Analysis
ann_ret_sect = zeros(NumAssets, 1);
ann_vol_sect = zeros(NumAssets, 1);
sharpe_sect = zeros(NumAssets, 1);
DD_sect = zeros(NumAssets, 1);
Calmar_sect = zeros(NumAssets, 1);

for i=1:NumAssets
    w_i=zeros(NumAssets,1);
    w_i(i)=1;
    [ann_ret_sect(i), ann_vol_sect(i), sharpe_sect(i), DD_sect(i), Calmar_sect(i)] = get_performance_metrics(w_i, Prices_oos);
end

table_sect = table(names', ann_ret_sect, ann_vol_sect, sharpe_sect, DD_sect, Calmar_sect, ...
                          'VariableNames', ["Sectors", "AnnualReturn", ...
                                            "AnnualVolatility", "SharpeRatio", ...
                                            "MaxDD", "Calmar"])


