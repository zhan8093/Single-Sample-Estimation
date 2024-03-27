#zeta, gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end, real_In_exist_at_gamma, expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, hat_lambda_0, hat_lambda_1, hat_r_1, hat_alpha = OSE.Simulate_main(10000)
if __name__ == "__main__":
    import one_sample_estimation as OSE
    import random
    import pandas as pd
    import numpy as np
    import math
    from matplotlib import pylab as plt
    from bisect import bisect
    import scipy.optimize
    k = 2
    r_0 = 1.0  # birth rate for Type 1
    d_0 = 1.5  # death rate for Type 1
    lambda_0 = r_0 - d_0  # net growth rate for Type 1

    r_1 = 1.5  # birth rate for Type 2
    d_1 = 1.0  # death rate for Type 2
    lambda_1 = r_1 - d_1  # net growth rate for Type 2

    #n = 100000  # initial size of Type 1

    # mu*n^(-alpha) is mutation rate
    mu = 1
    alpha = 0.5
    #n_list = np.array([500,1000,5000,10000,50000,100000,500000,1000000])
    # n_list = np.array([1000])
    # simu_result_expectation = pd.DataFrame(
    #     columns=['500'], index=['zeta', 'expec_In_exist_to_end', 'expec_Rn_gamma', 'Phi_0_gamma', 'lambda_0', 'lambda_1', 'r_1', 'alpha'])
    # simu_result_gamma = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_gamma_star = pd.DataFrame(
    #     columns=['500'], index=range(k))
    # simu_result_real_In_exist_to_end = pd.DataFrame(
    #     columns=['500'], index=range(k))
    # simu_result_real_In_exist_at_gamma = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_real_Rn_gamma = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_Z0_gamma = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_hat_lambda_0 = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_hat_lambda_1 = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_hat_r_1 = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_hat_alpha = pd.DataFrame(
    #     columns = ['500'], index = range(k))
    # simu_result_U = pd.DataFrame(
    #     columns=['500'], index=range(k))
    # simu_result_hat_lambda_1_prime = pd.DataFrame(
    #     columns=['500'], index=range(k))
    # simu_result_hat_r_1_prime = pd.DataFrame(
    #     columns=['500'], index=range(k))
    # simu_result_U_prime = pd.DataFrame(
    #     columns=['500'], index=range(k))
    n_list = np.array([100, 200, 400, 800,1600, 3200, 6400, 12800, 25600, 51200, 102400, 204800, 409600, 819200, 1638400, 3276800, 6553600, 13107200, 26214400, 52428800, 104857600])
#    n_list = np.array([500,1000,2000,4000,8000,16000,32000,64000,128000,256000,512000,1024000,2024000,4048000,8096000,16192000])
    simu_result_expectation = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=['zeta', 'expec_In_exist_to_end', 'expec_Rn_gamma', 'Phi_0_gamma', 'lambda_0', 'lambda_1', 'r_1', 'alpha'])
    simu_result_gamma = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_gamma_star = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
    simu_result_real_In_exist_to_end = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
    simu_result_real_In_exist_at_gamma = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_real_Rn_gamma = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_Z0_gamma = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_hat_lambda_0 = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_hat_lambda_1 = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_hat_r_1 = pd.DataFrame(
        columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_U = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
    simu_result_hat_lambda_1_prime = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
    simu_result_hat_r_1_prime = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
 #   simu_result_U_prime = pd.DataFrame(
 #       columns=['500', '1000', '2000', '4000', '8000', '16000', '32000', '64000', '128000', '256000', '512000',
 #                '1024000'], index=range(k))
 #   simu_result_hat_r_1_star1 = pd.DataFrame(
 #       columns=['500', '1000', '2000', '4000', '8000', '16000', '32000', '64000', '128000', '256000', '512000',
 #                '1024000'], index=range(k))
 #   simu_result_hat_r_1_star2 = pd.DataFrame(
 #       columns=['500', '1000', '2000', '4000', '8000', '16000', '32000', '64000', '128000', '256000', '512000',
 #                '1024000'], index=range(k))
 #   simu_result_hat_r_1_star3 = pd.DataFrame(
 #       columns=['500', '1000', '2000', '4000', '8000', '16000', '32000', '64000', '128000', '256000', '512000',
 #                '1024000'], index=range(k))
    simu_result_hat_alpha = pd.DataFrame(
       columns = ['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index = range(k))
    simu_result_hat_alpha_prime = pd.DataFrame(
        columns=['100', '200', '400', '800','1600', '3200', '6400', '12800', '25600', '51200', '102400', '204800', '409600', '819200', '1638400', '3276800', '6553600', '13107200', '26214400', '52428800', '104857600'], index=range(k))
#    simu_result_temp = pd.DataFrame(
#        columns=['500', '1000', '2000', '4000', '8000', '16000', '32000', '64000', '128000', '256000', '512000',
#                 '1024000'], index=range(k))

    index = 0
    for n in n_list:
        print(n)
        simu_list = [x for x in range(k)]
        simu_list_gamma = [x for x in range(k)]
        simu_list_gamma_star = [x for x in range(k)]
        simu_list_real_In_exist_to_end = [x for x in range(k)]
        simu_list_real_In_exist_at_gamma = [x for x in range(k)]
        simu_list_real_Rn_gamma = [x for x in range(k)]
        simu_list_Z0_gamma = [x for x in range(k)]
        simu_list_hat_lambda_0 = [x for x in range(k)]
        simu_list_hat_lambda_1 = [x for x in range(k)]
        simu_list_hat_r_1 = [x for x in range(k)]
        simu_list_U = [x for x in range(k)]
#        simu_list_U_prime = [x for x in range(k)]
        simu_list_hat_r_1_prime = [x for x in range(k)]
        simu_list_hat_lambda_1_prime = [x for x in range(k)]
#        simu_list_hat_r_1_star1 = [x for x in range(k)]
#        simu_list_hat_r_1_star2 = [x for x in range(k)]
#        simu_list_hat_r_1_star3 = [x for x in range(k)]
        simu_list_hat_alpha = [x for x in range(k)]
        simu_list_hat_alpha_prime = [x for x in range(k)]
#        simu_list_temp = [x for x in range(k)]
        for i in range(k):
            zeta, gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end,\
            real_In_exist_at_gamma, expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, \
            hat_lambda_0, hat_lambda_1, hat_r_1 ,\
            hat_alpha , U, hat_lambda_1_prime, hat_r_1_prime, hat_alpha_prime = OSE.Simulate_main(n, r_0, d_0, lambda_0, r_1, d_1, lambda_1, mu, alpha)
            while hat_alpha ==0:
                            zeta, gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end,\
                            real_In_exist_at_gamma, expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, \
                            hat_lambda_0, hat_lambda_1, hat_r_1 ,\
                            hat_alpha , U, hat_lambda_1_prime, hat_r_1_prime, hat_alpha_prime = OSE.Simulate_main(n, r_0, d_0, lambda_0, r_1, d_1, lambda_1, mu, alpha)   
            simu_list_gamma[i] = gamma
            simu_list_gamma_star[i] = gamma_star
            simu_list_real_In_exist_to_end[i] = real_In_exist_to_end
            simu_list_real_In_exist_at_gamma[i] = real_In_exist_at_gamma
            simu_list_real_Rn_gamma[i] = real_Rn_gamma
            simu_list_Z0_gamma[i] = Z0_gamma
            simu_list_hat_lambda_0[i] = hat_lambda_0
            simu_list_hat_lambda_1[i] = hat_lambda_1
            simu_list_hat_r_1[i] = hat_r_1
            simu_list_U[i] = U
#            simu_list_U_prime[i] = U_prime
            simu_list_hat_r_1_prime[i] = hat_r_1_prime
            simu_list_hat_lambda_1_prime[i] = hat_lambda_1_prime
#            simu_list_hat_r_1_star1[i] = hat_r_1_star1
#            simu_list_hat_r_1_star2[i] = hat_r_1_star2
#            simu_list_hat_r_1_star3[i] = hat_r_1_star3
            simu_list_hat_alpha[i] = hat_alpha
            simu_list_hat_alpha_prime[i] = hat_alpha_prime
#            simu_list_temp[i] = temp

        simu_result_gamma.iloc[:, index] = simu_list_gamma
        simu_result_gamma_star.iloc[:, index] = simu_list_gamma_star
        simu_result_real_In_exist_to_end.iloc[:, index] = simu_list_real_In_exist_to_end
        simu_result_real_In_exist_at_gamma.iloc[:, index] = simu_list_real_In_exist_at_gamma
        simu_result_real_Rn_gamma.iloc[:, index] = simu_list_real_Rn_gamma
        simu_result_Z0_gamma.iloc[:, index] = simu_list_Z0_gamma
        simu_result_hat_lambda_0.iloc[:, index] = simu_list_hat_lambda_0
        simu_result_hat_lambda_1.iloc[:, index] = simu_list_hat_lambda_1
        simu_result_hat_r_1.iloc[:, index] = simu_list_hat_r_1
        simu_result_U.iloc[:, index] = simu_list_U
#        simu_result_U_prime.iloc[:, index] = simu_list_U_prime
        simu_result_hat_r_1_prime.iloc[:, index] = simu_list_hat_r_1_prime
        simu_result_hat_lambda_1_prime.iloc[:, index] = simu_list_hat_lambda_1_prime
#        simu_result_hat_r_1_star1.iloc[:, index] = simu_list_hat_r_1_star1
#        simu_result_hat_r_1_star2.iloc[:, index] = simu_list_hat_r_1_star2
#        simu_result_hat_r_1_star3.iloc[:, index] = simu_list_hat_r_1_star3
        simu_result_hat_alpha.iloc[:, index] = simu_list_hat_alpha
        simu_result_hat_alpha_prime.iloc[:, index] = simu_list_hat_alpha_prime
#        simu_result_temp.iloc[:, index] = simu_list_temp
        simu_result_expectation.iloc[:,index] = [zeta, expec_In_exist_to_end, expec_Rn_gamma, Phi_0_gamma, lambda_0, lambda_1, r_1, alpha]

        index += 1

    simu_result_gamma.to_csv('simu_result_gamma.csv', index=False)
    simu_result_gamma_star.to_csv('simu_result_gamma_star.csv', index=False)
    simu_result_real_In_exist_to_end.to_csv('simu_result_real_In_exist_to_end.csv', index=False)
    simu_result_real_In_exist_at_gamma.to_csv('simu_result_real_In_exist_at_gamma.csv', index=False)
    simu_result_real_Rn_gamma.to_csv('simu_result_real_Rn_gamma.csv', index=False)
    simu_result_Z0_gamma.to_csv('simu_result_Z0_gamma.csv', index=False)
    simu_result_hat_lambda_0.to_csv('simu_result_hat_lambda_0.csv', index=False)
    simu_result_hat_lambda_1.to_csv('simu_result_hat_lambda_1.csv', index=False)
    simu_result_hat_r_1.to_csv('simu_result_hat_r_1.csv', index=False)
#    simu_result_U.to_csv('simu_result_U.csv', index=False)
#    simu_result_U_prime.to_csv('simu_result_U_prime.csv', index=False)
#    simu_result_hat_r_1_prime.to_csv('simu_result_hat_r_1_prime.csv', index=False)
#    simu_result_hat_lambda_1_prime.to_csv('simu_result_hat_lambda_1_prime.csv', index=False)
#    simu_result_hat_r_1_star1.to_csv('simu_result_hat_r_1_star1.csv', index=False)
#    simu_result_hat_r_1_star2.to_csv('simu_result_hat_r_1_star2.csv', index=False)
#    simu_result_hat_r_1_star3.to_csv('simu_result_hat_r_1_star3.csv', index=False)
    simu_result_hat_alpha.to_csv('simu_result_hat_alpha.csv', index=False)
#    simu_result_hat_alpha_prime.to_csv('simu_result_hat_alpha_prime.csv', index=False)
#    simu_result_temp.to_csv('simu_result_temp.csv', index=False)
    simu_result_expectation.to_csv('simu_result_expectation.csv', index=True)
