data_expec = readtable('simu_result_expectation.csv');
data_expec = data_expec{2:end,2:end};
data_lambda0 = readtable('simu_result_hat_lambda_0.csv');
data_lambda0 = data_lambda0{2:end,1:end};
data_lambda1 = readtable('simu_result_hat_lambda_1.csv');
data_lambda1 = data_lambda1{2:end,1:end};
data_alpha = readtable('simu_result_hat_alpha.csv');
data_alpha = data_alpha{2:end,1:end};
data_r1 = readtable('simu_result_hat_r_1.csv');
data_r1 = data_r1{2:end,1:end};
%data = data(data<0.5);
%data = data./0.5; %relative error
n_list =[100, 200, 400, 800,1600, 3200, 6400, 12800, 25600, 51200, 102400, 204800, 409600, 819200, 1638400, 3276800, 6553600, 13107200, 26214400, 52428800, 104857600];
len = length(n_list);
mean_error_lambda0 = zeros(1, len);
std_error_lambda0 = zeros(1,len);
mean_error_lambda1 = zeros(1, len);
std_error_lambda1 = zeros(1,len);
mean_error_alpha = zeros(1, len);
std_error_alpha = zeros(1,len);
mean_error_r1 = zeros(1, len);
std_error_r1 = zeros(1,len);
for i = 1:len
    data_expec_i = data_expec(:,i);
    zeta = data_expec_i(1);
    expec_In_exist_to_end = data_expec_i(2);
    expec_Rn_gamma = data_expec_i(3);
    Phi_0_gamma = data_expec_i(4);
    lambda_0 = data_expec_i(5);
    lambda_1 = data_expec_i(6);
    r_1 = data_expec_i(7);
    Alpha = data_expec_i(8);
    U = -lambda_0/lambda_1;
    u_zeta = (1-Alpha)/3;
    n = n_list(i);
    
   

    %data_list0 = data(1:50,i);
    %data_list1 = data(51:100,i);
    %data_list0 = data_list0(data_list0<1);
    %data_list1 = data_list1(data_list1<1);
    data_lambda0_i = data_lambda0(:,i);
    data_lambda0_i = data_lambda0_i(data_lambda0_i ~= 0);
    data_lambda1_i = data_lambda1(:,i);
    data_lambda1_i = data_lambda1_i(data_lambda1_i ~= 0);
    data_alpha_i = data_alpha(:,i);
    data_alpha_i = data_alpha_i(data_alpha_i ~= 0);  
    data_r1_i = data_r1(:,i);
    data_r1_i = data_r1_i(data_r1_i ~= 0);
    mean_error_lambda0(i) = mean(abs((data_lambda0_i - lambda_0)./lambda_0));
    std_error_lambda0(i) = std(abs((data_lambda0_i - lambda_0)./lambda_0));
    mean_error_lambda1(i) = mean(abs((data_lambda1_i - lambda_1)./lambda_1));
    std_error_lambda1(i) = std(abs((data_lambda1_i - lambda_1)./lambda_1));
    mean_error_alpha(i) = mean(abs((data_alpha_i - Alpha)./Alpha));
    std_error_alpha(i) = std(abs((data_alpha_i - Alpha)./Alpha));
    mean_error_r1(i) = mean(abs((data_r1_i - r_1)./r_1));
    std_error_r1(i) = std(abs((data_r1_i - r_1)./r_1));
end

figure(1);
semilogx(n_list, mean_error_lambda0, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]); % Main line
hold on;

curve1 = mean_error_lambda0 + std_error_lambda0;
curve2 = mean_error_lambda0 - std_error_lambda0;
fill([n_list, fliplr(n_list)], [curve1, fliplr(curve2)], [0.9, 0.9, 1], 'LineStyle', 'none'); % Error fill

semilogx(n_list, mean_error_lambda0, 'LineWidth', 2.5, 'Color', [0, 0.447, 0.741]); % Replot main line for clarity

set(gca, 'XScale', 'log', 'FontSize', 12);
xlabel('initial tumor burden $(n)$', 'FontSize', 14,'Interpreter','latex');
ylabel('relative error of $\hat{\lambda}^{(n)}_0$', 'FontSize', 14,'Interpreter','latex');
grid on;
xlim([100, 110000000]);
%title('Performance of estimator for \lambda_0', 'FontSize', 16);

saveas(gcf, 'lambda_0_error.png', 'png');


figure(2);
semilogx(n_list, mean_error_lambda1, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]); % Main line
hold on;

curve1 = mean_error_lambda1 + std_error_lambda1;
curve2 = mean_error_lambda1 - std_error_lambda1;
fill([n_list, fliplr(n_list)], [curve1, fliplr(curve2)], [0.9, 0.9, 1], 'LineStyle', 'none'); % Error fill

semilogx(n_list, mean_error_lambda1, 'LineWidth', 2.5, 'Color', [0, 0.447, 0.741]); % Replot main line for clarity

set(gca, 'XScale', 'log', 'FontSize', 12);
xlabel('initial tumor burden $(n)$', 'FontSize', 14,'Interpreter','latex');
ylabel('relative error of $\hat{\lambda}^{(n)}_1$', 'FontSize', 14,'Interpreter','latex');
grid on;
xlim([100, 110000000]);
%title('Performance of estimator for \lambda_1', 'FontSize', 16);

saveas(gcf, 'lambda_1_error.png', 'png');

figure(3);
semilogx(n_list, mean_error_alpha, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]); % Main line
hold on;

curve1 = mean_error_alpha + std_error_alpha;
curve2 = mean_error_alpha - std_error_alpha;
fill([n_list, fliplr(n_list)], [curve1, fliplr(curve2)], [0.9, 0.9, 1], 'LineStyle', 'none'); % Error fill

semilogx(n_list, mean_error_alpha, 'LineWidth', 2.5, 'Color', [0, 0.447, 0.741]); % Replot main line for clarity

set(gca, 'XScale', 'log', 'FontSize', 12);
xlabel('initial tumor burden $(n)$', 'FontSize', 14,'Interpreter','latex');
ylabel('relative error of $\hat{\alpha}^{(n)}$', 'FontSize', 14,'Interpreter','latex');
grid on;
xlim([100, 110000000]);
%title('Performance of estimator for \alpha', 'FontSize', 16);

saveas(gcf, 'alpha_error.png', 'png');


figure(4);
semilogx(n_list, mean_error_r1, 'LineWidth', 2, 'Color', [0, 0.447, 0.741]); % Main line
hold on;

curve1 = mean_error_r1 + std_error_r1;
curve2 = mean_error_r1 - std_error_r1;
fill([n_list, fliplr(n_list)], [curve1, fliplr(curve2)], [0.9, 0.9, 1], 'LineStyle', 'none'); % Error fill

semilogx(n_list, mean_error_r1, 'LineWidth', 2.5, 'Color', [0, 0.447, 0.741]); % Replot main line for clarity

set(gca, 'XScale', 'log', 'FontSize', 12);
xlabel('initial tumor burden $(n)$', 'FontSize', 14,'Interpreter','latex');
ylabel('relative error of $\hat{r}^{(n)}_1$', 'FontSize', 14,'Interpreter','latex');
grid on;
xlim([12800, 110000000]);
%title('Performance of estimator for r_1', 'FontSize', 16);

saveas(gcf, 'r1_error.png', 'png');



% ind = 1:len;
% %plot(n_list, mean_error, 'LineWidth',2,Color=[0,0,1]);
% figure
% area(n_list, [transpose(mean_error_lambda0-std_error_lambda0), transpose(2*std_error_lambda0)],EdgeColor="none");
% colororder([1,1,1;1,1,1;0.3010 0.7450 0.9330]);
% alpha(0.1);
% hold on;
% semilogx(n_list, mean_error_lambda0, 'LineWidth',2,Color=[0,0,1]);
% %set(gca,'XTick',ind);
% %set(gca,'XTickLabel',{'500','1000','2000','4000','8000','16000','32000','64000','128000','256000','512000','1024000'});
% xlabel('Number of initial cells n');
% ylabel('Relative estimation error of \lambda_0 ');
% xlim([500,2048000]);
% 
% figure
% semilogx(n_list, mean_error1, 'LineWidth',2,Color=[0,0,1]);
% hold on
% area(n_list, [transpose(mean_error1-std_error1), transpose(2*std_error1)],EdgeColor="none");
% colororder([1,1,1;1,1,1;0,0,1]);
% alpha(0.1);
% %set(gca,'XTick',ind);
% %set(gca,'XTickLabel',{'500','1000','2000','4000','8000','16000','32000','64000','128000','256000','512000','1024000'});
% xlabel('Number of initial cells n');
% ylabel('Relative estimation error of \lambda_1 ');
% xlim([500,1024000]);




