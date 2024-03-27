exp_result = readtable('exp_result.csv');
real_result = readtable('real_result.csv');
clone_list = readtable('clone_list.csv','ReadVariableNames', false);
n = 1e7;

zeta = exp_result{1, 'Value'};
expec_In_exist_to_end = exp_result{2,'Value'};
expec_Rn_gamma = exp_result{3,'Value'};
Phi_0_gamma = exp_result{4, 'Value'};
lambda_0 = exp_result{5, 'Value'};
lambda_1 = exp_result{6, 'Value'};
r_1 = exp_result{7, 'Value'};
alpha = exp_result{8, 'Value'};


num_simu = length(real_result{1,2:end});
boot_Rns = zeros(1,num_simu);
boot_lam1s = zeros(1,num_simu);
boot_alps = zeros(1,num_simu);
boot_r1s = zeros(1,num_simu);
for col = 1:num_simu
    gamma = real_result{1,col+1};
    In = real_result{2,col+1};
    Rn = real_result{3,col+1};
    Z0 = real_result{4,col+1};
    hat_lambda_0 = real_result{5,col+1};
    hat_lambda_1 = real_result{6,col+1};
    hat_r_1 = real_result{7,col+1};
    hat_alpha = real_result{8,col+1};
    clones = table2cell(clone_list(col,:));
    %clones = clones(~cellfun(@isnan,clones));
    %clones = cell2mat(clones);
    clones = clones(~cellfun('isempty',clones));
    clones = cellfun(@str2double, clones);

    len = length(clones);
    sample_len = round(0.7*len);
    original_Rn = simpsonIndex(clones);
    sorted_clones = sort(clones, 'descend');
    top_20_percent_length = ceil(length(sorted_clones) * 0.2);
    top_20_percent_clones = sorted_clones(1:top_20_percent_length);
    left_clones = sorted_clones(top_20_percent_length+1:end);
    % Bootstrap parameters
    numBootstraps = 1000; % Number of bootstrap samples
    bootstrapIndices = zeros(numBootstraps, 1); % Preallocate array for bootstrap indices
    
    % Perform bootstrapping
    for i = 1:numBootstraps
        % Sample with replacement to create a bootstrap sample
        Sampleclones = randsample(left_clones,ceil(length(sorted_clones) * 0.50),true);
        bootstrapSample = [top_20_percent_clones,Sampleclones];
        % Calculate Simpson Index for the bootstrap sample
        bootstrapIndices(i) = simpsonIndex(bootstrapSample);
    end
    
    % Calculate the average bootstrap Simpson Index
    boot_Rn = mean(bootstrapIndices);
    boot_Rns(col) = boot_Rn;
    K = In * boot_Rn;
    U = sqrt(K) / sqrt(K - 2) - 1;
    boot_lam1 = - hat_lambda_0 / U;
    boot_r1 = (1 / U + 1) * n / In * boot_lam1 / ...
              (exp(boot_lam1 * gamma));
    boot_alp = 1 - log(In)/log(n) - ...
                      log((-hat_lambda_0 * boot_r1) / boot_lam1)/log(n);
    boot_lam1s(col) = boot_lam1;
    boot_r1s(col) = boot_r1;
    boot_alps(col) = boot_alp;
end
newRowData = {'boot_Rn'};
newRowData = [newRowData, num2cell(boot_Rns)];
newRow = cell2table(newRowData, 'VariableNames', real_result.Properties.VariableNames);

% Append the new row to the original table
real_result = [real_result; newRow];

newRowData = {'boot_lam1'};
newRowData = [newRowData, num2cell(boot_lam1s)];
newRow = cell2table(newRowData, 'VariableNames', real_result.Properties.VariableNames);

% Append the new row to the original table
real_result = [real_result; newRow];

newRowData = {'boot_alp'};
newRowData = [newRowData, num2cell(boot_alps)];
newRow = cell2table(newRowData, 'VariableNames', real_result.Properties.VariableNames);

% Append the new row to the original table
real_result = [real_result; newRow];

newRowData = {'boot_r1'};
newRowData = [newRowData, num2cell(boot_r1s)];
newRow = cell2table(newRowData, 'VariableNames', real_result.Properties.VariableNames);

% Append the new row to the original table
real_result = [real_result; newRow];

filename = 'boot_real_result.csv'; % Define the filename and path if needed
writetable(real_result, filename);



