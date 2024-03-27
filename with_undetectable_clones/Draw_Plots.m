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
data_Rn = readtable('simu_result_real_Rn_gamma.csv');
data_Rn = data_Rn{2:end,1:end};

data_lambda1_6 = readtable('simu_result_hat_lambda_1_6.csv');
data_lambda1_6 = data_lambda1_6{2:end,1:end};
data_alpha_6 = readtable('simu_result_hat_alpha_6.csv');
data_alpha_6 = data_alpha_6{2:end,1:end};
data_r1_6 = readtable('simu_result_hat_r_1_6.csv');
data_r1_6 = data_r1_6{2:end,1:end};
data_Rn_6 = readtable('simu_result_real_Rn_gamma_6.csv');
data_Rn_6 = data_Rn_6{2:end,1:end};

data_lambda1_8 = readtable('simu_result_hat_lambda_1_8.csv');
data_lambda1_8 = data_lambda1_8{2:end,1:end};
data_alpha_8 = readtable('simu_result_hat_alpha_8.csv');
data_alpha_8 = data_alpha_8{2:end,1:end};
data_r1_8 = readtable('simu_result_hat_r_1_8.csv');
data_r1_8 = data_r1_8{2:end,1:end};
data_Rn_8 = readtable('simu_result_real_Rn_gamma_8.csv');
data_Rn_8 = data_Rn_8{2:end,1:end};
%data = data(data<0.5);
%data = data./0.5; %relative error
n_list =[100, 200, 400, 800,1600, 3200, 6400, 12800, 25600, 51200, 102400, 204800, 409600, 819200, 1638400, 3276800, 6553600, 13107200, 26214400];
len = length(n_list);
mean_error_lambda0 = zeros(1, len);
std_error_lambda0 = zeros(1,len);

mean_error_lambda1 = zeros(1, len);
std_error_lambda1 = zeros(1,len);

mean_error_alpha = zeros(1, len);
std_error_alpha = zeros(1,len);

mean_error_r1 = zeros(1, len);
std_error_r1 = zeros(1,len);

mean_error_Rn = zeros(1,len);
std_error_Rn = zeros(1,len);

mean_error_lambda1_6 = zeros(1, len);
std_error_lambda1_6 = zeros(1,len);

mean_error_alpha_6 = zeros(1, len);
std_error_alpha_6 = zeros(1,len);

mean_error_r1_6 = zeros(1, len);
std_error_r1_6 = zeros(1,len);

mean_error_Rn_6 = zeros(1,len);
std_error_Rn_6 = zeros(1,len);

mean_error_lambda1_8 = zeros(1, len);
std_error_lambda1_8 = zeros(1,len);

mean_error_alpha_8 = zeros(1, len);
std_error_alpha_8 = zeros(1,len);

mean_error_r1_8 = zeros(1, len);
std_error_r1_8 = zeros(1,len);

mean_error_Rn_8 = zeros(1,len);
std_error_Rn_8 = zeros(1,len);
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
    
    data_lambda0_i = data_lambda0(:,i);
    data_lambda0_i = data_lambda0_i(data_lambda0_i ~= 0);

    data_lambda1_i = data_lambda1(:,i);
    data_lambda1_i = data_lambda1_i(data_lambda1_i ~= 0);

    data_alpha_i = data_alpha(:,i);
    data_alpha_i = data_alpha_i(data_alpha_i ~= 0);

    data_r1_i = data_r1(:,i);
    data_r1_i = data_r1_i(data_r1_i ~= 0);

    data_Rn_i = data_Rn(:,i);
    data_Rn_i = data_Rn_i(data_Rn_i ~= 0);

    data_lambda1_6_i = data_lambda1_6(:,i);
    data_lambda1_6_i = data_lambda1_6_i(data_lambda1_6_i ~= 0);

    data_alpha_6_i = data_alpha_6(:,i);
    data_alpha_6_i = data_alpha_6_i(data_alpha_6_i ~= 0);

    data_r1_6_i = data_r1_6(:,i);
    data_r1_6_i = data_r1_6_i(data_r1_6_i ~= 0);

    data_Rn_6_i = data_Rn_6(:,i);
    data_Rn_6_i = data_Rn_6_i(data_Rn_6_i ~= 0);

    data_lambda1_8_i = data_lambda1_8(:,i);
    data_lambda1_8_i = data_lambda1_8_i(data_lambda1_8_i ~= 0);

    data_alpha_8_i = data_alpha_8(:,i);
    data_alpha_8_i = data_alpha_8_i(data_alpha_8_i ~= 0);

    data_r1_8_i = data_r1_8(:,i);
    data_r1_8_i = data_r1_8_i(data_r1_8_i ~= 0);

    data_Rn_8_i = data_Rn_8(:,i);
    data_Rn_8_i = data_Rn_8_i(data_Rn_8_i ~= 0);

    mean_error_lambda0(i) = mean(abs((data_lambda0_i - lambda_0)./lambda_0));
    std_error_lambda0(i) = std(abs((data_lambda0_i - lambda_0)./lambda_0));

    mean_error_lambda1(i) = mean(abs((data_lambda1_i - lambda_1)./lambda_1));
    std_error_lambda1(i) = std(abs((data_lambda1_i - lambda_1)./lambda_1));

    mean_error_alpha(i) = mean(abs((data_alpha_i - Alpha)./Alpha));
    std_error_alpha(i) = std(abs((data_alpha_i - Alpha)./Alpha));

    mean_error_r1(i) = mean(abs((data_r1_i - r_1)./r_1));
    std_error_r1(i) = std(abs((data_r1_i - r_1)./r_1));

    mean_error_Rn(i) = mean(abs((data_Rn_i - expec_Rn_gamma)./expec_Rn_gamma));
    std_error_Rn(i) = std(abs((data_Rn_i - expec_Rn_gamma)./expec_Rn_gamma));

    mean_error_lambda1_6(i) = mean(abs((data_lambda1_6_i - lambda_1)./lambda_1));
    std_error_lambda1_6(i) = std(abs((data_lambda1_6_i - lambda_1)./lambda_1));

    mean_error_alpha_6(i) = mean(abs((data_alpha_6_i - Alpha)./Alpha));
    std_error_alpha_6(i) = std(abs((data_alpha_6_i - Alpha)./Alpha));

    mean_error_r1_6(i) = mean(abs((data_r1_6_i - r_1)./r_1));
    std_error_r1_6(i) = std(abs((data_r1_6_i - r_1)./r_1));

    mean_error_Rn_6(i) = mean(abs((data_Rn_6_i - expec_Rn_gamma)./expec_Rn_gamma));
    std_error_Rn_6(i) = std(abs((data_Rn_6_i - expec_Rn_gamma)./expec_Rn_gamma));

    mean_error_lambda1_8(i) = mean(abs((data_lambda1_8_i - lambda_1)./lambda_1));
    std_error_lambda1_8(i) = std(abs((data_lambda1_8_i - lambda_1)./lambda_1));

    mean_error_alpha_8(i) = mean(abs((data_alpha_8_i - Alpha)./Alpha));
    std_error_alpha_8(i) = std(abs((data_alpha_8_i - Alpha)./Alpha));

    mean_error_r1_8(i) = mean(abs((data_r1_8_i - r_1)./r_1));
    std_error_r1_8(i) = std(abs((data_r1_8_i - r_1)./r_1));

    mean_error_Rn_8(i) = mean(abs((data_Rn_8_i - expec_Rn_gamma)./expec_Rn_gamma));
    std_error_Rn_8(i) = std(abs((data_Rn_8_i - expec_Rn_gamma)./expec_Rn_gamma));
end

% figure(1)
% semilogx(n_list, mean_error_lambda0);
% curve1 = mean_error_lambda0 + std_error_lambda0;
% curve2 = mean_error_lambda0 - std_error_lambda0;
% n_list2 = [n_list, fliplr(n_list)];
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_lambda0,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('lambda0 error')
% saveas(gca,'lambda_0_error.png');
% 
% 
% 
% figure(2)
% semilogx(n_list, mean_error_lambda1);
% curve1 = mean_error_lambda1 + std_error_lambda1;
% curve2 = mean_error_lambda1 - std_error_lambda1;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_lambda1,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('lambda1 error')
% saveas(gca,'lambda_1_error.png');
% 
% 
% figure(3)
% semilogx(n_list, mean_error_alpha);
% curve1 = mean_error_alpha + std_error_alpha;
% curve2 = mean_error_alpha - std_error_alpha;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_alpha,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('alpha error')
% saveas(gca,'alpha_error.png');
% 
% 
% figure(4)
% semilogx(n_list, mean_error_r1);
% curve1 = mean_error_r1 + std_error_r1;
% curve2 = mean_error_r1 - std_error_r1;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_r1,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('r1 error')
% saveas(gca,'r1_error.png');
% 
% 
% figure(5)
% semilogx(n_list, scaled_mean_error_gamma);
% curve1 = scaled_mean_error_gamma + scaled_std_error_gamma;
% curve2 = scaled_mean_error_gamma - scaled_std_error_gamma;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, scaled_mean_error_gamma,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('scaled gamma error')
% saveas(gca,'scaled_gamma_error.png');
% 
% 
% figure(6)
% semilogx(n_list, mean_error_lambda1_prime);
% curve1 = mean_error_lambda1_prime + std_error_lambda1_prime;
% curve2 = mean_error_lambda1_prime - std_error_lambda1_prime;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_lambda1_prime,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('lambda1 prime error')
% saveas(gca,'lambda_1_prime_error.png');
% 
% 
% figure(7)
% semilogx(n_list, mean_error_r1_prime);
% curve1 = mean_error_r1_prime + std_error_r1_prime;
% curve2 = mean_error_r1_prime - std_error_r1_prime;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_r1_prime,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('r1 prime error')
% saveas(gca,'r1_error_prime.png');
% 
% figure(8)
% semilogx(n_list, mean_error_alpha_prime);
% curve1 = mean_error_alpha_prime + std_error_alpha_prime;
% curve2 = mean_error_alpha_prime - std_error_alpha_prime;
% inBetween = [curve1, fliplr(curve2)];
% fill(n_list2, inBetween, 'cyan',EdgeColor="none");
% hold on;
% semilogx(n_list, mean_error_alpha_prime,'LineWidth',2,Color=[0,0,1]);
% set(gca, 'XScale', 'log');
% xlim([500,2048000]);
% title('alpha prime error')
% saveas(gca,'alpha_prime_error.png');

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

% Assuming x_values is your x-axis data and is the same size as your mean and std vectors


% Lambda plot with error bars
figure(1);
plot(log10(n_list), mean_error_lambda1, 'o-', 'LineWidth', 2);
hold on;
plot(log10(n_list), mean_error_lambda1_8, 'd-', 'LineWidth', 2);
plot(log10(n_list), mean_error_lambda1_6, 's-', 'LineWidth', 2);
hold off;
set(gca, 'XScale', 'log'); % Set the x-axis to logarithmic scaling
xlabel('initial population (log n)','Interpreter','latex');
ylabel('relative error of $\hat{\lambda}^{(n)}_1$','Interpreter','latex');
%title('Comparison of Esitimators for \lambda_1 with Miss Countings');
legend('no undetectable clones', 'smaller than 10% of n', 'smaller than 2% of n');
xlim([2 7.11]);
grid on;
saveas(gca, 'Miss_count_lambda_1.png');

% Alpha plot with error bars
figure(2);
plot(log10(n_list), mean_error_alpha, 'o-', 'LineWidth', 2);
hold on;
plot(log10(n_list), mean_error_alpha_8, 'd-', 'LineWidth', 2);
plot(log10(n_list), mean_error_alpha_6,  's-', 'LineWidth', 2);
hold off;
set(gca, 'XScale', 'log'); % Set the x-axis to logarithmic scaling
xlabel('initial population (log n)','Interpreter','latex');
ylabel('relative error of $\hat{\alpha}^{(n)}$','Interpreter','latex');
%title('Comparison of Esitimators for \lambda_1 with Miss Countings');
legend('no undetectable clones', 'smaller than 10% of n', 'smaller than 2% of n');
xlim([2.9 7.11]); 
%title('Comparison of Estimators for \alpha with Miss Countings');
grid on;
saveas(gca, 'Miss_count_alpha.png');
% r_1 plot with error bars
figure(3);
plot(log10(n_list), mean_error_r1,'o-', 'LineWidth', 1.5);
hold on;
plot(log10(n_list), mean_error_r1_8,  'd-', 'LineWidth', 1.5);
plot(log10(n_list), mean_error_r1_6,  's-', 'LineWidth', 1.5);
hold off;
set(gca, 'XScale', 'log'); % Set the x-axis to logarithmic scaling
xlabel('initial population (log n)','Interpreter','latex');
ylabel('relative error of $\hat{r}^{(n)}_1$','Interpreter','latex');
%title('Comparison of Esitimators for \lambda_1 with Miss Countings');
legend('no undetectable clones', 'smaller than 10% of n', 'smaller than 2% of n');
xlim([5.9 log10(20485760)]); 
grid on;
saveas(gca, 'Miss_count_r_1.png');


figure(4);
plot(log10(n_list), mean_error_Rn,  'o-', 'LineWidth', 1.5);
hold on;
plot(log10(n_list), mean_error_Rn_8, 'd-', 'LineWidth', 1.5);
plot(log10(n_list), mean_error_Rn_6, 's-', 'LineWidth', 1.5);
hold off;
set(gca, 'XScale', 'log'); % Set the x-axis to logarithmic scaling
xlim([3.5 7.1]);
xlabel('initial population (log n)','Interpreter','latex');
ylabel('relative error of $R_n$','Interpreter','latex');
%title('Comparison of Esitimators for \lambda_1 with Miss Countings');
legend('no undetectable clones', 'smaller than 10% of n', 'smaller than 2% of n');
grid on;
saveas(gca, 'Miss_count_Rn.png');
