import random
import pandas as pd
import numpy as np
import math
from matplotlib import pylab as plt
from bisect import bisect
import scipy.optimize


# def Rn_3_func(clone_list):
#     Z1 = sum(clone_list)
#     result = 0
#     for i in range(len(clone_list)):
#         result = result + (clone_list[i]/Z1)**3
#     return result
#
# def Rn_4_func(clone_list):
#     Z1 = sum(clone_list)
#     result = 0
#     for i in range(len(clone_list)):
#         result = result + (clone_list[i]/Z1)**4
#     return result

def bdBranchList(r, d, labmda, n, T):
    time_list = [0]
    transition_list = [n]
    t = 0
    s = n
    if s == 0:
        return s
    v1 = np.random.rand(1)
    next_birth = - 1 / (r * s) * math.log(v1)
    v2 = np.random.rand(1)
    next_death = - 1 / (d * s) * math.log(v2)

    duration = min(next_birth, next_death)
    transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death
    t = t + duration
    while t < T:
        s = s + transition
        time_list.append(t)
        transition_list.append(s)
        if s == 0:
            break
        v1 = np.random.rand(1)
        next_birth = - 1 / (r * s) * math.log(v1)
        v2 = np.random.rand(1)
        next_death = - 1 / (d * s) * math.log(v2)

        duration = min(next_birth, next_death)
        transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death

        t = t + duration


    return time_list, transition_list


## Birth-Death Branching process, output size of clones

def bdBranchNum(r, d, labmda, t_0, T, n):
    t = 0
    s = n
    v1 = np.random.rand(1)
    if s == 0:
        return s
    next_birth = - 1 / (r * s) * math.log(v1)
    v2 = np.random.rand(1)
    next_death = - 1 / (d * s) * math.log(v2)

    duration = min(next_birth, next_death)
    transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death
    t = t + duration
    while t < T - t_0:
        s = s + transition
        if s == 0:
            break
        v1 = np.random.rand(1)
        next_birth = - 1 / (r * s) * math.log(v1)
        v2 = np.random.rand(1)
        next_death = - 1 / (d * s) * math.log(v2)

        duration = min(next_birth, next_death)
        transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death
        t = t + duration

    return s

def Simulate_main(n, r_0, d_0, lambda_0, r_1, d_1, lambda_1, mu , alpha):
    C = 500000
    r = -lambda_0
    #n= 10000
    rate = pow(n, -alpha)

    def Phi_0(t):
        result = n * math.exp(lambda_0 * t)
        return result

    def Phi_1(t):
        result = 1 / (lambda_1 - lambda_0) * pow(n, 1-alpha) * math.exp(lambda_1 * t) * (
                1 - math.exp((lambda_0 - lambda_1) * t))
        return result

    # number of clones that will survive forever
    def expec_In(t):
        result = lambda_1 * pow(n, 1-alpha) / (r * r_1)
        return result

    def expec_In_generated(t):
        result =  pow(n, 1-alpha) / r
        return result

    def Rn_func(clone_list):
        Z1 = sum(clone_list)
        result = 0
        for i in range(len(clone_list)):
            result = result + (clone_list[i]/Z1)**2
        return result

    def expec_Rn(t):
        result = pow(n, alpha-1) * 2 * r_1 * (lambda_1-lambda_0)**2/(lambda_1* (2*lambda_1 - lambda_0))
        return result

    def zeta_func(t):
        result = 1 / (lambda_1 - lambda_0) * pow(n, -alpha) * math.exp(lambda_1 * t) * (
                1 - math.exp((lambda_0 - lambda_1) * t)) - 1
        return result


    def zeta_star_func(t):
        result = 1 / (lambda_1 - lambda_0) * pow(n, -alpha) * math.exp(lambda_1 * t) * (
                1 - math.exp((lambda_0 - lambda_1) * t)) + math.exp(lambda_0 * t) - 1
        return result

    x0 = alpha * math.log(n) / lambda_1
    zeta = scipy.optimize.fsolve(zeta_func, x0)
    zeta_star = scipy.optimize.fsolve(zeta_star_func, x0)

    T_end = 1.3 * zeta[0]

    ## Generate Type 1, birth-death branching process
    time_list0, transition_list0 = bdBranchList(r_0, d_0, lambda_0, n, T_end)

    # number of clones and their generation time from time 0 to T_end
    clones_starting_time = []

    # simulation of generation of clones
    t = 0
    Z0_max = max(transition_list0)
    lambda_max = Z0_max * rate
    u1 = np.random.rand(1)
    next_clone = t - 1 / lambda_max * math.log(u1)  # the time the next mutation might happen
    t = next_clone
    while t < T_end:
        u2 = np.random.rand(1)
        next_clone = t - 1 / lambda_max * math.log(u2)  # the time the next mutation might happen
        t = next_clone
        u3 = np.random.rand(1)
        Z_0_now = transition_list0[bisect(time_list0, t) - 1]
        lambda_t = Z_0_now * rate
        if u3 <= lambda_t / lambda_max:
            clones_starting_time.append(t)

    # for each clone, record its growth from generation to T_end
    Clones_Growth = [[1] for x in clones_starting_time]
    Clones_Growth_Time = [[x] for x in clones_starting_time]
    for i in range(len(Clones_Growth)):
        starting_time = clones_starting_time[i]
        t = starting_time
        current_size = 1
        total_pop = transition_list0[bisect(time_list0, t) - 1]
        for j in range(len(Clones_Growth)):
            if t > Clones_Growth_Time[j][0]:
                total_pop = total_pop + Clones_Growth[j][bisect(Clones_Growth_Time[j], t) - 1]
        r1 = r_1 * (1 - total_pop / C)
        v1 = np.random.rand(1)
        next_birth = - 1 / (r1 * current_size) * math.log(v1)
        v2 = np.random.rand(1)
        next_death = - 1 / (d_1 * current_size) * math.log(v2)

        duration = min(next_birth, next_death)
        transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death
        t = t + duration
        while t < T_end:
            current_size = current_size + transition
            Clones_Growth_Time[i].append(t)
            Clones_Growth[i].append(current_size)
            if current_size == 0:
                break
            total_pop = transition_list0[bisect(time_list0, t) - 1]
            first_growth_times = [growth_time[0] for growth_time in Clones_Growth_Time]
            for j, (growth, first_growth_time) in enumerate(zip(Clones_Growth, first_growth_times)):
                if t > first_growth_time:
                    bisect_index = bisect(Clones_Growth_Time[j], t) - 1
                    total_pop += growth[bisect_index]
            r1 = r_1 * (1 - total_pop / C)
            v1 = np.random.rand(1)
            next_birth = - 1 / (r1 * current_size) * math.log(v1)
            v2 = np.random.rand(1)
            next_death = - 1 / (d_1 * current_size) * math.log(v2)

            duration = min(next_birth, next_death)
            transition = (-np.argmin([next_birth, next_death]) * 2) + 1  # return 1 or -1, represents birth or death

            t = t + duration

    # calculate Z_0 and Z_1 at different time
    interval = 0.001
    check_time = np.arange(0, T_end, interval)
    Z0_list = [0 for t in check_time]
    Z1_list = [0 for t in check_time]
    Z0_plus_Z1_list = [0 for t in check_time]
    iter = 0
    flag1 = 0
    flag2 = 0
    gamma = 0
    gamma_star = 0
    for t in check_time:
        Z0 = transition_list0[bisect(time_list0, t) - 1]
        Z1 = 0
        for i in range(len(Clones_Growth)):
            if t > Clones_Growth_Time[i][0]:
                Z1 = Z1 + Clones_Growth[i][bisect(Clones_Growth_Time[i], t) - 1]
        Z0_list[iter] = Z0
        Z1_list[iter] = Z1
        if not flag1 and Z1 > n:
            gamma = t
            flag1 = 1
        if not flag2 and t > zeta[0]/10 and Z0 + Z1 > n:
            gamma_star = t
            flag2 = 1
        Z0_plus_Z1_list[iter] = Z0 + Z1
        iter = iter + 1

    # find Z0(gamma_n)
    Z0_gamma = Z0_list[bisect(check_time, gamma) - 1]
    Phi_0_gamma = Phi_0(gamma)
    # calculate In(gamma) and E[In(gamma)]
    clone_list_exist_to_end = []
    clone_list_exist_at_gamma = []
    clone_list_generate_before_gamma = []
    for i in range(len(Clones_Growth)):
        if gamma > clones_starting_time[i]:
            clone_list_generate_before_gamma.append(i)
            if Clones_Growth[i][bisect(Clones_Growth_Time[i], gamma) - 1] > 0:
                clone_list_exist_at_gamma.append(i)
            if Clones_Growth[i][bisect(Clones_Growth_Time[i], T_end) - 1] > 0:
                clone_list_exist_to_end.append(i)

    expec_In_gen_gamma = expec_In_generated(gamma)
    real_In_gen_gamma = len(clone_list_generate_before_gamma)
    expec_In_exist_to_end = expec_In(gamma)
    real_In_exist_to_end = len(clone_list_exist_to_end)
    real_In_exist_at_gamma = len(clone_list_exist_at_gamma)

    # calculate Rn(gamma) and E[Rn(gamma)]
    clone_num_list_exist_at_gamma = []
    for i in clone_list_exist_at_gamma:
        clone_num_list_exist_at_gamma.append(Clones_Growth[i][bisect(Clones_Growth_Time[i], gamma) - 1])
    real_Rn_gamma = Rn_func(clone_num_list_exist_at_gamma)
    expec_Rn_gamma = expec_Rn(gamma)

    # calculate the estimators
    K = real_In_exist_at_gamma * real_Rn_gamma
    if K - 2 > 0 and Z0_gamma > 0:
        U = math.sqrt(K) / math.sqrt(K - 2) - 1
        hat_lambda_0 = math.log(Z0_gamma / n) / gamma

        hat_lambda_1 = - hat_lambda_0 / U
        hat_r_1 = (1 / U + 1) * n / real_In_exist_at_gamma * hat_lambda_1 / (
            math.exp(hat_lambda_1 * gamma))
        try:
            hat_alpha = 1 - math.log(real_In_exist_at_gamma, n) - \
                          math.log((-hat_lambda_0 * hat_r_1)/hat_lambda_1, n)
        except:
            print('hat_lambda_0:',hat_lambda_0,'hat_r_1:',hat_r_1,'hat_lambda_1:',hat_lambda_1)
    else:
        hat_lambda_0 = 0
        hat_lambda_1 = 0
        hat_r_1 = 0
        hat_alpha = 0


    return zeta[0], gamma, gamma_star, expec_In_exist_to_end, real_In_exist_to_end, real_In_exist_at_gamma, \
           expec_Rn_gamma, real_Rn_gamma, Phi_0_gamma, Z0_gamma, hat_lambda_0, hat_lambda_1, hat_r_1, \
            hat_alpha, clone_num_list_exist_at_gamma


