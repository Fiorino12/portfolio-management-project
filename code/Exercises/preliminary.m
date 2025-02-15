% PRELIMINARY
display(" Preliminary")

filename = 'prices.xlsx';
date_first=datetime('01/01/2023', 'InputFormat', 'dd/MM/yyyy');
date_last=datetime('31/12/2023', 'InputFormat', 'dd/MM/yyyy');

[names,LogReturns,Exp_Ret,Cov_Ret,Prices,Dates,Cap]=ImportData(filename,date_first,date_last);
