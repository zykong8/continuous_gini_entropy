import numpy as np
import pandas as pd

from scipy.stats import differential_entropy
from entropy_estimators import continuous


def GetGini(arr):
    uniqVal, counts = np.unique(np.sort(np.append(arr, 0)), return_counts=True)
    stat = pd.DataFrame({"UniqVal":uniqVal, "Counts":counts})

    stat["totalVal"] = stat["UniqVal"] * stat['Counts']
    stat["totalValCum"] = stat["totalVal"].cumsum()
    stat["totalValRatio"] = stat["totalValCum"] / stat["totalValCum"].max()

    stat["countCum"] = stat["Counts"].cumsum()
    stat["countRatio"] = stat["countCum"] / stat["countCum"].max()

    B = np.trapz(y=stat["totalValRatio"], x=stat["countRatio"])
    A = 0.5 - B
    G = A / (A + B)

    # stat.plot(x="countRatio", y="totalValRatio")
    return(f'{G:0.6f}')

def GetEntropy(arr):
    # 一种无参熵估计法(non-parametric entropy estimation)可以避免划分bins来计算熵值，
    # 包括了核密度估计(kernel density estimator, KDE)和k-近邻估计(k-NN estimator)。
    # 核密度估计法运算量太大，k-近邻估计成为了普遍使用的一种计算连续随机变量的熵值方式。
    # compute the entropy from the determinant of the 
    # multivariate normal distribution (KDE):
    analytic = continuous.get_h_mvn(arr)

    # compute the entropy using the k-nearest neighbour approach
    # developed by Kozachenko and Leonenko (1987):
    kozachenko = continuous.get_h(arr, k=5)

    # compute the entropy using Differential entropy (scipy.stats)
    # method{‘vasicek’, ‘van es’, ‘ebrahimi’, ‘correa’, ‘auto’}, optional
    # The method used to estimate the differential entropy from the sample. Default is 'auto'. 
    SCI = differential_entropy(arr)

    # Entropy
    ent = {"KDE-Est": f'{analytic:0.6f}', "KNN-Est": f'{kozachenko:0.6}', "scipy.stats-Est": f'{SCI:0.6f}'}

    return(ent)

if __name__ == '__main__':
    vals = np.array([1.7, 2.3, 3.5, 10, 4.2, 2.3, 1.7, 2.2, 3.5, 5.1, 
           9.5, 9.5, 1.7, 2.3, 3.5, 1.7, 2.3, 5.1, 4.7, 2.3, 
           4.7, 12])
    print(GetGini(vals))
    print(GetEntropy(vals))