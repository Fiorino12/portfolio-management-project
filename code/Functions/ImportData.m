function [names,LogReturns,Exp_Ret,Cov_Ret,Prices,Dates,Cap]=ImportData(filename,date_first,date_last)
    %% INPUT
    % filename
    % date_first (datetime)
    % date_last (datetime)
    %% OUTPUT
    % names : Names of the market indeces
    % LogReturns : Historical Logreturns
    % Exp_Ret : Expected Return vector
    % Cov_Ret : Variance Matrix of the returns
    % Cap: Capitalizations

    %% 
    fprintf('Importing the dataset "%s" \n', filename);
    Date1 = datestr(date_first);        % convert datetime into string
    Date2 = datestr(date_last);         % convert datetime into string
    fprintf('Time Range : (%s,%s) ', Date1,Date2);
    
    % Upload dats as table type:
    prices_tab = readtable(filename); 

    % Transform prices from table to timetable type
    date = prices_tab(:,1).Variables;                       % dates (type=datetime)
    values = prices_tab(:,2:end).Variables;                 % prices (type=double)
    names = prices_tab.Properties.VariableNames(2:end);     % indeces names (type=cell)

    myPrice_dt = array2timetable(values, 'RowTimes', date,'Variablenames', names);

    % Select the time range
    range=timerange(date_first, date_last, 'closed');       % Including the extremes

    % Select the subsample of interest
    prices_sub = myPrice_dt(range,:);
    Prices = prices_sub.Variables;
    Dates = prices_sub.Time;

    % LogReturn=log(Si+1/Si):
    LogReturns = tick2ret(Prices, 'Method', 'Continuous');
    % Mean:
    Exp_Ret=mean(LogReturns);
    % Var-Cov Matrix;
    Cov_Ret=cov(LogReturns);
    
    % Capitalization:
    cap=readtable('capitalizations.xlsx');
    cap=cap(1,2:end);
    cap=table2array(cap);
    Cap=cap';
    
    
end