exp_result = readtable('exp_result.csv');

zeta = exp_result{1, 'Value'};
expec_In_exist_to_end = exp_result{2,'Value'};
expec_Rn_gamma = exp_result{3,'Value'};
Phi_0_gamma = exp_result{4, 'Value'};
lambda_0 = exp_result{5, 'Value'};
lambda_1 = exp_result{6, 'Value'};
r_1 = exp_result{7, 'Value'};
alpha = exp_result{8, 'Value'};

real_C2 = readtable('real_result_2.csv');
lam1_C2 = real_C2(6,2:end);
lam0_C2 = real_C2(5,2:end);
alpha_C2 = real_C2(8,2:end);
lam1_C2 = table2array(lam1_C2);
lam0_C2 = table2array(lam0_C2);
alpha_C2 = table2array(alpha_C2);
err_lam1_C2 = abs(lam1_C2 - lambda_1)/lambda_1;
err_lam0_C2 = -abs(lam0_C2 - lambda_0)/lambda_0;
err_alpha_C2 = abs(alpha_C2 - alpha)/alpha;

real_C25 = readtable('real_result_2dot5.csv');
lam1_C25 = real_C25(6,2:end);
lam0_C25 = real_C25(5,2:end);
alpha_C25 = real_C25(8,2:end);
lam1_C25 = table2array(lam1_C25);
lam0_C25 = table2array(lam0_C25);
alpha_C25 = table2array(alpha_C25);
err_lam1_C25 = abs(lam1_C25 - lambda_1)/lambda_1;
err_lam0_C25 = -abs(lam0_C25 - lambda_0)/lambda_0;
err_alpha_C25 = abs(alpha_C25 - alpha)/alpha;

real_C3 = readtable('real_result_3.csv');
lam1_C3 = real_C3(6,2:end);
lam0_C3 = real_C3(5,2:end);
alpha_C3 = real_C3(8,2:end);
lam1_C3 = table2array(lam1_C3);
lam0_C3 = table2array(lam0_C3);
alpha_C3 = table2array(alpha_C3);
err_lam1_C3 = abs(lam1_C3 - lambda_1)/lambda_1;
err_lam0_C3 = -abs(lam0_C3 - lambda_0)/lambda_0;
err_alpha_C3 = abs(alpha_C3 - alpha)/alpha;

real_C35 = readtable('real_result3dot5.csv');
lam1_C35 = real_C35(6,2:end);
lam0_C35 = real_C35(5,2:end);
alpha_C35 = real_C35(8,2:end);
lam1_C35 = table2array(lam1_C35);
lam0_C35 = table2array(lam0_C35);
alpha_C35 = table2array(alpha_C35);
err_lam1_C35 = abs(lam1_C35 - lambda_1)/lambda_1;
err_lam0_C35 = -abs(lam0_C35 - lambda_0)/lambda_0;
err_alpha_C35 = abs(alpha_C35 - alpha)/alpha;

real_C4 = readtable('real_result_4.csv');
lam1_C4 = real_C4(6,2:end);
lam0_C4 = real_C4(5,2:end);
alpha_C4 = real_C4(8,2:end);
lam1_C4 = table2array(lam1_C4);
lam0_C4 = table2array(lam0_C4);
alpha_C4 = table2array(alpha_C4);
err_lam1_C4 = abs(lam1_C4 - lambda_1)/lambda_1;
err_lam0_C4 = -abs(lam0_C4 - lambda_0)/lambda_0;
err_alpha_C4 = abs(alpha_C4 - alpha)/alpha;

real_C45 = readtable('real_result4dot5.csv');
lam1_C45 = real_C45(6,2:end);
lam0_C45 = real_C45(5,2:end);
alpha_C45 = real_C45(8,2:end);
lam1_C45 = table2array(lam1_C45);
lam0_C45 = table2array(lam0_C45);
alpha_C45 = table2array(alpha_C45);
err_lam1_C45 = abs(lam1_C45 - lambda_1)/lambda_1;
err_lam0_C45 = -abs(lam0_C45 - lambda_0)/lambda_0;
err_alpha_C45 = abs(alpha_C45 - alpha)/alpha;

real_C5 = readtable('real_result_5.csv');
lam1_C5 = real_C5(6,2:end);
lam0_C5 = real_C5(5,2:end);
alpha_C5 = real_C5(8,2:end);
lam1_C5 = table2array(lam1_C5);
lam0_C5 = table2array(lam0_C5);
alpha_C5 = table2array(alpha_C5);
err_lam1_C5 = abs(lam1_C5 - lambda_1)/lambda_1;
err_lam0_C5 = -abs(lam0_C5 - lambda_0)/lambda_0;
err_alpha_C5 = abs(alpha_C5 - alpha)/alpha;

capacity = [2, 2.5, 3, 3.5, 4, 4.5 ,5];

%Corresponding Y values as a matrix where each row is an array of errors for a given x
err_lam1_values = [err_lam1_C2;err_lam1_C25;err_lam1_C3;err_lam1_C35;err_lam1_C4;err_lam1_C45;err_lam1_C5];
err_lam0_values = [err_lam0_C2;err_lam0_C25;err_lam0_C3;err_lam0_C35;err_lam0_C4;err_lam0_C45;err_lam0_C5];
err_alpha_values = [err_alpha_C2;err_alpha_C25;err_alpha_C3;err_alpha_C35;err_alpha_C4;err_alpha_C45;err_alpha_C5];

% Create a figure
figure(1);
hold on;  % Hold on to keep the plot window open for multiple plots

% Assuming 'capacity' and 'err_lam1_values' are defined and have correct dimensions

% Choose a colormap that provides distinct colors for each set of points
colors = lines(numel(capacity));

% Loop over each x and y array to plot the scatter plot
for i = 1:length(capacity)
    % Increase the size of the markers and use the colormap
    scatter(repmat(capacity(i), 1, length(err_lam1_values(i,:))), err_lam1_values(i,:), ...
            'MarkerEdgeColor', [0,0,0], ...
            'MarkerFaceColor',[0,0,0], ...
            'LineWidth', 1.5, ...  % Adjust the line width around markers
            'SizeData', 50);  % Adjust the size of the markers
end

% Labels and title with improved fonts
xlabel('capacity (\times 10^5)', 'FontSize', 18);
ylabel('relative error of $\hat{\lambda}^{(n)}_1$', 'FontSize', 18, 'Interpreter','latex');
%title('relative error of $\hat{\lambda}^{(n)}_1$', 'FontSize', 24,'Interpreter','latex');

% Add grid lines for better readability
grid on;
set(gca, 'GridLineStyle', '--');  % Set grid line style
set(gca, 'GridAlpha', 0.7);  % Set the transparency of the grid lines

% Improve the tick marks
set(gca, 'FontSize', 15);  % Set the font size for the tick labels

% If the capacity values are discrete and you want to label each group, you can set the x-ticks manually
set(gca, 'xtick', capacity);  

% Optionally, you can add a legend if it makes sense for your data
%legend(arrayfun(@(n) ['x = ' num2str(n)], capacity, 'UniformOutput', false), 'Location', 'northeast', 'FontSize', 10);
saveas(gca,'with_capacity_lambda_1.png');
hold off;  % Done plotting


figure(2);
hold on;  % Hold on to keep the plot window open for multiple plots

% Assuming 'capacity' and 'err_lam1_values' are defined and have correct dimensions

% Choose a colormap that provides distinct colors for each set of points
colors = lines(numel(capacity));

% Loop over each x and y array to plot the scatter plot
for i = 1:length(capacity)
    % Increase the size of the markers and use the colormap
    scatter(repmat(capacity(i), 1, length(err_alpha_values(i,:))), err_alpha_values(i,:), ...
            'MarkerEdgeColor', [0,0,0], ...
            'MarkerFaceColor', [0,0,0], ...
            'LineWidth', 1.5, ...  % Adjust the line width around markers
            'SizeData', 50);  % Adjust the size of the markers
end

% Labels and title with improved fonts
xlabel('capacity (\times 10^5)', 'FontSize', 18);
ylabel('relative error of $\hat{\alpha}^{(n)}$', 'FontSize', 18, 'Interpreter','latex');

% Add grid lines for better readability
grid on;
set(gca, 'GridLineStyle', '--');  % Set grid line style
set(gca, 'GridAlpha', 0.7);  % Set the transparency of the grid lines

% Improve the tick marks
set(gca, 'FontSize', 15);  % Set the font size for the tick labels

% If the capacity values are discrete and you want to label each group, you can set the x-ticks manually
set(gca, 'xtick', capacity);  

% Optionally, you can add a legend if it makes sense for your data
%legend(arrayfun(@(n) ['x = ' num2str(n)], capacity, 'UniformOutput', false), 'Location', 'northeast', 'FontSize', 10);
saveas(gca,'with_capacity_alpha.png');
hold off;  % Done plotting

% Create a figure
figure(3);
hold on;  % Hold on to keep the plot window open for multiple plots

% Assuming 'capacity' and 'err_lam1_values' are defined and have correct dimensions

% Choose a colormap that provides distinct colors for each set of points
colors = lines(numel(capacity));

% Loop over each x and y array to plot the scatter plot
for i = 1:length(capacity)
    % Increase the size of the markers and use the colormap
    scatter(repmat(capacity(i), 1, length(err_lam0_values(i,:))), err_lam0_values(i,:), ...
            'MarkerEdgeColor', [0,0,0], ...
            'MarkerFaceColor',[0,0,0], ...
            'LineWidth', 1.5, ...  % Adjust the line width around markers
            'SizeData', 50);  % Adjust the size of the markers
end

% Labels and title with improved fonts
xlabel('capacity (\times 10^5)', 'FontSize', 18);
ylabel('relative error of $\hat{\lambda}^{(n)}_0$', 'FontSize', 18, 'Interpreter','latex');

% Add grid lines for better readability
grid on;
set(gca, 'GridLineStyle', '--');  % Set grid line style
set(gca, 'GridAlpha', 0.7);  % Set the transparency of the grid lines

% Improve the tick marks
set(gca, 'FontSize', 15);  % Set the font size for the tick labels

% If the capacity values are discrete and you want to label each group, you can set the x-ticks manually
set(gca, 'xtick', capacity);  

% Optionally, you can add a legend if it makes sense for your data
%legend(arrayfun(@(n) ['x = ' num2str(n)], capacity, 'UniformOutput', false), 'Location', 'northeast', 'FontSize', 10);
saveas(gca,'with_capacity_lambda_0.png');
hold off;  % Done plotting



% % Perform one-way ANOVA
% [p_lam1, tbl_lam1, stats_lam1] = anova1(err_lam1_values');
% [p_alpha, tbl_alpha, stats_alpha] = anova1(err_alpha_values');

[h_lam1, p_lam1, ci_lam1, stats_lam1] = ttest2(err_lam1_C5, err_lam1_C2, 'Vartype', 'unequal', 'Tail', 'left');
t_lam1 = stats_lam1.tstat;
len = length(err_lam1_values)-1;
p_lam1 = tcdf(t_lam1,len);

[h_alpha, p_alpha, ci_alpha, stats_alpha] = ttest2(err_alpha_C5, err_alpha_C2, 'Vartype', 'unequal', 'Tail', 'left');
t_alpha = stats_alpha.tstat;
p_alpha = tcdf(t_alpha,len);

[h_lam0, p_lam0, ci_lam0, stats_lam0] = ttest2(err_lam0_C5, err_lam0_C2, 'Vartype', 'unequal', 'Tail', 'left');
t_lam0 = stats_lam0.tstat;
len = length(err_lam0_values)-1;
p_lam0 = tcdf(t_lam0,len);

lam1_mean = mean(err_lam1_values,2);
alpha_mean = mean(err_alpha_values,2);
lam0_mean = mean(err_lam0_values,2);