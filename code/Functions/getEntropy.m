function e = getEntropy(x)
    %% Input:
    % x: vector of portfolio weights (must sum to 1 and contain non-negative values)

    %% Output:
    % e: The entropy in portfolio weights of the distribution represented by x, computed as 
    %    -∑(x(i) * log(x(i))), where the sum is over all non-zero elements of x.

    e = 0;
    for i = 1:length(x)
        % Only consider non-zero elements to avoid log(0), which is undefined
        if (x(i) ~= 0)
            e = e - x(i)*log(x(i));
        end
    end
end