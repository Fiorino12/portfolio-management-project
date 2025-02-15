function []=printptf(name,w,ret,vol)
    % Prints the details of a portfolio including its name, weights, 
    % expected return, and volatility.
    %
    % INPUT:
    %   name  -  Name of the portfolio.
    %   w     -  Portfolio weights for each asset.
    %   ret   -  Expected return of the portfolio.
    %   vol   -  Volatility of the portfolio.
    %
    % OUTPUT:
    %   None (the function prints portfolio details to the console).

    fprintf(name);
    fprintf(' : [')
    fprintf('%.2f ', w);
    fprintf(']\n');
    fprintf('Expected Return: %f   Volatility: %f  \n\n', ret, vol)
end