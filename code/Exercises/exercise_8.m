% EXERCISE 8
% PERFROMANCE METRICS 
display(" Exercise 8 ")

% Equally weighted portfolio
w_EW = 1/NumAssets*ones(NumAssets,1);
exp_EW = w_EW' * Exp_Ret';
vol_EW = w_EW' * Cov_Ret * w_EW;

% Performance Metrics
ann_ret=zeros(16,1);
ann_vol=zeros(16,1);
sharpe=zeros(16,1);
DD=zeros(16,1);
Calmar=zeros(16,1);

[ann_ret(1), ann_vol(1), sharpe(1), DD(1), Calmar(1)] = get_performance_metrics(wMKT, Prices);
[ann_ret(2), ann_vol(2), sharpe(2), DD(2), Calmar(2)] = get_performance_metrics(w_EW, Prices);
[ann_ret(3), ann_vol(3), sharpe(3), DD(3), Calmar(3)] = get_performance_metrics(w_A, Prices);
[ann_ret(4), ann_vol(4), sharpe(4), DD(4), Calmar(4)] = get_performance_metrics(w_B, Prices);
[ann_ret(5), ann_vol(5), sharpe(5), DD(5), Calmar(5)] = get_performance_metrics(w_C, Prices);
[ann_ret(6), ann_vol(6), sharpe(6), DD(6), Calmar(6)] = get_performance_metrics(w_D, Prices);
[ann_ret(7), ann_vol(7), sharpe(7), DD(7), Calmar(7)] = get_performance_metrics(w_E, Prices);
[ann_ret(8), ann_vol(8), sharpe(8), DD(8), Calmar(8)] = get_performance_metrics(w_F, Prices);
[ann_ret(9), ann_vol(9), sharpe(9), DD(9), Calmar(9)] = get_performance_metrics(w_G, Prices);
[ann_ret(10), ann_vol(10), sharpe(10), DD(10), Calmar(10)] = get_performance_metrics(w_H, Prices);
[ann_ret(11), ann_vol(11), sharpe(11), DD(11), Calmar(11)] = get_performance_metrics(w_I, Prices);
[ann_ret(12), ann_vol(12), sharpe(12), DD(12), Calmar(12)] = get_performance_metrics(w_L, Prices);
[ann_ret(13), ann_vol(13), sharpe(13), DD(13), Calmar(13)] = get_performance_metrics(w_M, Prices);
[ann_ret(14), ann_vol(14), sharpe(14), DD(14), Calmar(14)] = get_performance_metrics(w_N, Prices);
[ann_ret(15), ann_vol(15), sharpe(15), DD(15), Calmar(15)] = get_performance_metrics(w_P, Prices);
[ann_ret(16), ann_vol(16), sharpe(16), DD(16), Calmar(16)] = get_performance_metrics(w_Q, Prices);

portfolios = ["MKT PORTFOLIO","PORTFOLIO EW","PORTFOLIO A", "PORTFOLIO B", "PORTFOLIO C", "PORTFOLIO D", ...
              "PORTFOLIO E", "PORTFOLIO F", "PORTFOLIO G", "PORTFOLIO H", ...
              "PORTFOLIO I", "PORTFOLIO L", "PORTFOLIO M", "PORTFOLIO N", ...
              "PORTFOLIO P", "PORTFOLIO Q"];
performance_table = table(portfolios', ann_ret, ann_vol, sharpe, DD, Calmar, ...
                          'VariableNames', ["Portfolio", "AnnualReturn", ...
                                            "AnnualVolatility", "SharpeRatio", ...
                                            "MaxDD", "Calmar"])
% Get diversification metrics
Div_ratio = zeros(16, 1);
Entropy = zeros(16, 1);

[Div_ratio(1), Entropy(1)] = get_diversification_metrics(wMKT, LogReturns);
[Div_ratio(2), Entropy(2)] = get_diversification_metrics(w_EW, LogReturns);
[Div_ratio(3), Entropy(3)] = get_diversification_metrics(w_A, LogReturns);
[Div_ratio(4), Entropy(4)] = get_diversification_metrics(w_B, LogReturns);
[Div_ratio(5), Entropy(5)] = get_diversification_metrics(w_C, LogReturns);
[Div_ratio(6), Entropy(6)] = get_diversification_metrics(w_D, LogReturns);
[Div_ratio(7), Entropy(7)] = get_diversification_metrics(w_E, LogReturns);
[Div_ratio(8), Entropy(8)] = get_diversification_metrics(w_F, LogReturns);
[Div_ratio(9), Entropy(9)] = get_diversification_metrics(w_G, LogReturns);
[Div_ratio(10), Entropy(10)] = get_diversification_metrics(w_H, LogReturns);
[Div_ratio(11), Entropy(11)] = get_diversification_metrics(w_I, LogReturns);
[Div_ratio(12), Entropy(12)] = get_diversification_metrics(w_L, LogReturns);
[Div_ratio(13), Entropy(13)] = get_diversification_metrics(w_M, LogReturns);
[Div_ratio(14), Entropy(14)] = get_diversification_metrics(w_N, LogReturns);
[Div_ratio(15), Entropy(15)] = get_diversification_metrics(w_P, LogReturns);
[Div_ratio(16), Entropy(16)] = get_diversification_metrics(w_Q, LogReturns);

diversification_table = table(portfolios', Div_ratio, Entropy, ...
                          'VariableNames', ["Portfolio", "DiversificationRatio", ...
                                            "Entropy"])


%%
investment = 1;
% benchmark portfolio --> Capitalization ptf and Equally Weighted
shares_CAP = investment * wMKT ./Prices(1,:)'; 
shares_EW = investment * w_EW ./Prices(1,:)'; 
%  get the number of shares for each asset for each portfolio
shares_A = investment * w_A ./ Prices(1,:)';
shares_B = investment * w_B ./ Prices(1,:)';
shares_C = investment * w_C ./ Prices(1,:)';
shares_D = investment * w_D ./ Prices(1,:)';
shares_E = investment * w_E ./ Prices(1,:)';
shares_F = investment * w_F ./ Prices(1,:)';
shares_G = investment * w_G ./ Prices(1,:)';
shares_H = investment * w_H ./ Prices(1,:)';
shares_I = investment * w_I ./ Prices(1,:)';
shares_L = investment * w_L ./ Prices(1,:)';
shares_M = investment * w_M ./ Prices(1,:)';
shares_N = investment * w_N ./ Prices(1,:)';
shares_P = investment * w_P ./ Prices(1,:)';
shares_Q = investment * w_Q ./ Prices(1,:)';


plot(Dates, Prices * shares_CAP, 'LineWidth', 3, 'Color', [1, 0.6, 0]); 
hold on
plot(Dates, Prices * shares_EW, 'LineWidth', 3, 'Color', [0, 0.75, 1]); 

plot(Dates, Prices * shares_A, 'LineWidth', 1, 'Color', [0 0.4470 0.7410]); 
plot(Dates, Prices * shares_B, 'LineWidth', 1, 'Color', [0.8500 0.3250 0.0980]); 
plot(Dates, Prices * shares_C, 'LineWidth', 1, 'Color', [0.9290 0.6940 0.1250]);
plot(Dates, Prices * shares_D, 'LineWidth', 1, 'Color', [0.4940 0.1840 0.5560]); 
plot(Dates, Prices * shares_E, 'LineWidth', 1, 'Color', [0.4660 0.6740 0.1880]); 
plot(Dates, Prices * shares_F, 'LineWidth', 1, 'Color', [0.3010 0.7450 0.9330]); 
plot(Dates, Prices * shares_G, 'LineWidth', 1, 'Color', [0.6350 0.0780 0.1840]); 
plot(Dates, Prices * shares_H, 'LineWidth', 1, 'Color', [0.5 0.5 0.5]); 
plot(Dates, Prices * shares_I, 'LineWidth', 1, 'Color', [0.25 0.25 0.75]); 
plot(Dates, Prices * shares_L, 'LineWidth', 1, 'Color', [0.75 0.25 0.25]); 
plot(Dates, Prices * shares_M, 'LineWidth', 1, 'Color', [0.25 0.75 0.25]); 
plot(Dates, Prices * shares_N, 'LineWidth', 1, 'Color', [0.75 0.75 0]); 
plot(Dates, Prices * shares_P, 'LineWidth', 1, 'Color', [0.4 0.6 0.8]); 
plot(Dates, Prices * shares_Q, 'LineWidth', 1, 'Color', [0.8 0.4 0.6]);

%title and legend
title('Portfolios', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Date', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Value', 'FontSize', 12, 'FontWeight', 'bold');
legend({'CAP', 'EW', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'L', 'M', 'N', 'P', 'Q'}, ...
    'Location', 'eastoutside', 'FontSize', 8);
grid on;
set(gca, 'FontSize', 12, 'LineWidth', 1, 'Box', 'on');

% Axes
xticks(linspace(Dates(1), Dates(end), 6));
xlim([Dates(1), Dates(end)]);
ylim([0.9 * investment, 1.6 * investment]);

% plot position
ax = gca;
ax.Position = [0.1 0.15 0.75 0.8]; 


