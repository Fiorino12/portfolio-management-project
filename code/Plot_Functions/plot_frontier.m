function [] = plot_frontier(volatility,expected_return,vol_MV,exp_MV,vol_SR,exp_SR,title_plot,name_MV, name_SR)
        % Plots the Efficient Frontier, highlighting the Minimum Variance Portfolio (MVP)
        % and the Maximum Sharpe Ratio Portfolio (MSRP).
        %
        % INPUT:
        %   volatility        -  Volatility values of portfolios on the Efficient Frontier.
        %   expected_return   -  Expected return corresponding to each volatility value.
        %   vol_MV            -  Volatility of the Minimum Variance Portfolio (MVP).
        %   exp_MV            -  Expected return of the Minimum Variance Portfolio (MVP).
        %   vol_SR            -  Volatility of the Maximum Sharpe Ratio Portfolio (MSRP).
        %   exp_SR            -  Expected return of the Maximum Sharpe Ratio Portfolio (MSRP).
        %   title_plot        -  Title of the plot.
        %   name_MV           -  Label for the Minimum Variance Portfolio (MVP).
        %   name_SR           -  Label for the Maximum Sharpe Ratio Portfolio (MSRP).
        %
        % OUTPUT:
        %   None (the function generates a plot on the screen).


        % portfolio
        plot(volatility,expected_return, 'LineStyle', '-', 'LineWidth', 2,'Color','b')
        title(title_plot,'FontSize', 14)
        hold on
        grid on 
        plot(vol_MV,exp_MV,'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g')
        text(vol_MV,exp_MV, name_MV, 'VerticalAlignment', 'bottom', 'FontSize', 10, 'Color', 'g')
        hold on
        plot(vol_SR,exp_SR, 'o', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r')
        text(vol_SR,exp_SR, name_SR, 'VerticalAlignment', 'top', 'FontSize', 10, 'Color', 'r')
        xlabel('Volatility','FontSize', 12)
        ylabel('Expected Return','FontSize', 12)
        legend('Efficient Frontier', name_MV, name_SR, 'FontSize', 10, 'Location', 'best')
        axis auto
        hold off        
end



