import one_sample_estimation as OSE
import random
import pandas as pd
import numpy as np
import math
from matplotlib import pylab as plt
from bisect import bisect
import scipy.optimize
import csv

k = 3
r_0 = 1.0  # birth rate for Type 1
d_0 = 1.5  # death rate for Type 1
lambda_0 = r_0 - d_0  # net growth rate for Type 1

r_1 = 1.5  # birth rate for Type 2
d_1 = 1.0  # death rate for Type 2
lambda_1 = r_1 - d_1  # net growth rate for Type 2

mu = 1
alpha = 0.5

n = 1000000
column_names = [f"Value {i}" for i in range(1, k + 1)]
simu_result_expectation = pd.DataFrame(columns =['Value'],index=['zeta', 'expec_In_exist_to_end', 'expec_Rn_gamma', 'Phi_0_gamma', 'lambda_0', 'lambda_1', 'r_1', 'alpha'])
simu_result_real = pd.DataFrame(columns =column_names,index = ['gamma',' real_In_exist_to_end','real_Rn_gamma','Z0_gamma','hat_lambda_0','hat_lambda_1','hat_r_1','hat_alpha'])
csv_file = "clone_list.csv"
clone_list_list = []

for i in range(k):
    print("Iteration:", i+1, 'has started')
    zeta, gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end, \
        real_In_exist_at_gamma, expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, \
        hat_lambda_0, hat_lambda_1, hat_r_1, hat_alpha, clone_num_list_exist_at_gamma = OSE.Simulate_main(n, r_0, d_0,lambda_0, r_1,d_1, lambda_1, mu,alpha)
    while hat_alpha == 0:
        zeta, gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end, \
            real_In_exist_at_gamma, expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, \
            hat_lambda_0, hat_lambda_1, hat_r_1, \
            hat_alpha, clone_num_list_exist_at_gamma = OSE.Simulate_main(n, r_0, d_0, lambda_0, r_1, d_1, lambda_1, mu,alpha)
    clone_list_list.append(clone_num_list_exist_at_gamma)
    simu_result_real.iloc[:,i] = [gamma, real_In_exist_to_end, real_Rn_gamma, Z0_gamma, hat_lambda_0, hat_lambda_1, hat_r_1, hat_alpha]

simu_result_expectation.iloc[:,0] = [zeta, expec_In_exist_to_end, expec_Rn_gamma, Phi_0_gamma, lambda_0, lambda_1, r_1, alpha]

simu_result_expectation.to_csv('exp_result.csv')
simu_result_real.to_csv('real_result.csv')
# Open the CSV file in write mode
with open(csv_file, 'w', newline='') as file:
    # Create a CSV writer
    writer = csv.writer(file)

    # Write the list as a single row in the CSV file
    for row in clone_list_list:
        writer.writerow(row)
