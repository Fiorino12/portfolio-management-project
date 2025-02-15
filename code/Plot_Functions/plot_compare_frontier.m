function [] = plot_compare_frontier(volatility,expected_return,title_plot,frontier,option)
    % Plots and compares multiple efficient frontiers or highlights
    % simulated frontiers with their respective mean frontier.
    %
    % INPUT:
    %   volatility        -  Each column represents the volatility values for a specific frontier.
    %   expected_return   -  Each column represents the expected return values for a specific frontier.
    %   title_plot        -  Title of the plot.
    %   frontier          -  Names/labels of the frontiers to display in the legend.
    %   option            -  Plotting option:
    %                       1: Compare multiple frontiers.
    %                       2: Plot simulated frontiers and emphasize the mean frontier.
    %
    % OUTPUT:
    %   None (the function generates a plot on the screen).

    switch option
        case 1
            % compare frontier
            for k = 1:size(volatility,2)
                plot(volatility(:,k), expected_return(:,k),'LineStyle', '-', 'LineWidth', 2, 'DisplayName',frontier(k)) %'Color','blue')
                hold on
            end
            grid on 
            title(title_plot)
            xlabel('Volatility')
            ylabel('Expected Return')
            legend()
            %hold off
        case 2
            % plot simulated frontier and the respective mean frontier
            for k = 1:size(volatility,2)
                 if (k == size(volatility,2))
                     plot(volatility(:,k), expected_return(:,k),'LineStyle', '-', 'LineWidth', 5, 'Color','b')
                 else
                     plot(volatility(:,k), expected_return(:,k),'LineStyle', '-')
                 hold on
                 end
            grid on 
            title(title_plot)
            xlabel('Volatility')
            ylabel('Expected Return')
            %hold off
        end
        
end