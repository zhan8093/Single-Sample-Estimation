exp_result = readtable('exp_result.csv');
boot_result = readtable('boot_real_result.csv');

zeta = exp_result{1, 'Value'};
expec_In_exist_to_end = exp_result{2,'Value'};
expec_Rn_gamma = exp_result{3,'Value'};
Phi_0_gamma = exp_result{4, 'Value'};
lambda_0 = exp_result{5, 'Value'};
lambda_1 = exp_result{6, 'Value'};
r_1 = exp_result{7, 'Value'};
alpha = exp_result{8, 'Value'};

num_simu = length(boot_result{1,2:end});
Rn_list = boot_result(3,2:end);
Rn_list = table2array(Rn_list);
err_Rn_list = abs(Rn_list - expec_Rn_gamma)/ expec_Rn_gamma;
Rn_list_B = boot_result(9,2:end);
Rn_list_B = table2array(Rn_list_B);
err_Rn_list_B = abs(Rn_list_B - expec_Rn_gamma)/ expec_Rn_gamma;
%cutoff = floor(length(err_Rn_list) * 0.1);

% err_Rn_list_sorted = sort(err_Rn_list(:), 'ascend');  % Sort the array in descending order
% err_Rn_list = err_Rn_list_sorted(1:end-cutoff);  % Select the top 80%
% err_Rn_list_B_sorted = sort(err_Rn_list_B(:), 'ascend');  % Sort the array in descending order
% err_Rn_list_B = err_Rn_list_B_sorted(1:end-cutoff);  % Select the top 80%
ratio_Rn = err_Rn_list_B./err_Rn_list;

lam1_list = boot_result(6,2:end);
lam1_list = table2array(lam1_list);
err_lam1_list = abs(lam1_list - lambda_1)/ lambda_1;
lam1_list_B = boot_result(10,2:end);
lam1_list_B = table2array(lam1_list_B);
err_lam1_list_B = abs(lam1_list_B - lambda_1)/ lambda_1;
% err_lam1_list_sorted = sort(err_lam1_list(:), 'ascend');  % Sort the array in descending order
% err_lam1_list = err_lam1_list_sorted(1:end-cutoff);  % Select the top 80%
% err_lam1_list_B_sorted = sort(err_lam1_list_B(:), 'ascend');  % Sort the array in descending order
% err_lam1_list_B = err_lam1_list_B_sorted(1:end-cutoff);  % Select the top 80%
ratio_lam1 = err_lam1_list_B./err_lam1_list;

r1_list = boot_result(7,2:end);
r1_list = table2array(r1_list);
err_r1_list = abs(r1_list - r_1)/ r_1;
r1_list_B = boot_result(12,2:end);
r1_list_B = table2array(r1_list_B);
err_r1_list_B = abs(r1_list_B - r_1)/ r_1;
% err_r1_list_sorted = sort(err_r1_list(:), 'ascend');  % Sort the array in descending order
% err_r1_list = err_r1_list_sorted(1:end-cutoff);  % Select the top 80%
% err_r1_list_B_sorted = sort(err_r1_list_B(:), 'ascend');  % Sort the array in descending order
% err_r1_list_B = err_r1_list_B_sorted(1:end-cutoff);  % Select the top 80%
ratio_r1 = err_r1_list_B./err_r1_list;

alpha_list = boot_result(8,2:end);
alpha_list = table2array(alpha_list);
err_alpha_list = abs(alpha_list - alpha)/ alpha;
alpha_list_B = boot_result(11,2:end);
alpha_list_B = table2array(alpha_list_B);
err_alpha_list_B = abs(alpha_list_B - alpha)/ alpha;
% err_alpha_list_sorted = sort(err_alpha_list(:), 'ascend');  % Sort the array in descending order
% err_alpha_list = err_alpha_list_sorted(1:end-cutoff);  % Select the top 80%
% err_alpha_list_B_sorted = sort(err_alpha_list_B(:), 'ascend');  % Sort the array in descending order
% err_alpha_list_B = err_alpha_list_B_sorted(1:end-cutoff);  % Select the top 80%
ratio_alpha = err_alpha_list_B./err_alpha_list;

% figure(1);
% bar([err_alpha_list; err_alpha_list_B]');
% legend('Without Bootstrapping', 'With Bootstrapping');
% xlabel('Experiments');
% ylabel('Relative Error');
% title('Bootstrapping for estimator of \alpha');
% saveas(gcf,'BT_for_alpha.png');
% 
% figure(2);
% bar([err_lam1_list; err_lam1_list_B]');
% legend('Without Bootstrapping', 'With Bootstrapping');
% xlabel('Experiments');
% ylabel('Relative Error');
% title('Bootstrapping for estimator of \lambda_1');
% saveas(gcf,'BT_for_lambda1.png');
% 
% figure(3);
% bar([err_r1_list, err_r1_list_B]);
% legend('Without Bootstrapping', 'With Bootstrapping');
% xlabel('Experiments');
% ylabel('Relative Error');
% title('Bootstrapping for estimator of r_1');
% saveas(gcf,'BT_for_r1.png');
% 
%data = [err_r1_list,err_r1_list_B];
%violin(data);

% figure(4);
% bar([err_Rn_list; err_Rn_list_B]');
% legend('Without Bootstrapping', 'With Bootstrapping');
% xlabel('Experiments');
% ylabel('Relative Error');
% title('Bootstrapping for estimator of R_n');
% saveas(gcf,'BT_for_Rn.png');
% 'R_n', 'R_n^{BS}','\lambda_1','\lambda_1^{BS}','\alpha','\alpha^{BS}'
%data = [err_Rn_list, err_Rn_list_B,err_lam1_list, err_lam1_list_B,err_alpha_list, err_alpha_list_B];
%figure(5);
%violin(data,'x',[-1,0,2,3,5,6]);

% Customize the axes and title as needed
%xlabel('Data Sets');
%ylabel('Values');
%title('Violin Plots of Data Sets');
cutoff = floor(length(ratio_Rn) * 0.1);
ratio_Rn_sorted = sort(ratio_Rn(:), 'ascend');  % Sort the array in descending order
ratio_Rn = ratio_Rn_sorted(1:end-cutoff);  % Select the top 80%
ratio_lam1_sorted = sort(ratio_lam1(:), 'ascend');  % Sort the array in descending order
ratio_lam1 = ratio_lam1_sorted(1:end-cutoff);  % Select the top 80%
ratio_alpha_sorted = sort(ratio_alpha(:), 'ascend');  % Sort the array in descending order
ratio_alpha = ratio_alpha_sorted(1:end-cutoff);  % Select the top 80%
ratio_r1_sorted = sort(ratio_r1(:), 'ascend');  % Sort the array in descending order
ratio_r1 = ratio_r1_sorted(1:end-cutoff);  % Select the top 80%
figure(6);
data = [ratio_Rn, ratio_lam1,ratio_alpha,ratio_r1];
violin(data);
