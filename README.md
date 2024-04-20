### 计算连续变量的基尼系数和熵
- 连续变量的基尼系数计算
    - The Gini coefficient is a single number aimed at measuring the degree of inequality in a distribution. It is most often used in economics to measure how far a country's wealth or income distribution deviates from a totally equal distribution.
    - The Gini is the sum, over all income-ordered population-percentiles, of the shortfall, from equal-share, of the cumulative-income up to each population-percentile. ....with that summed shortfall divided by the greatest value that it could have, with complete inequality.
    - The Gini coefficient is usually defined mathematically based on the Lorenz curve, which plots the proportion of the total income of the population (y axis) that is cumulatively earned by the bottom x of the population (see diagram). The line at 45 degrees thus represents perfect equality of incomes. The Gini coefficient can then be thought of as the ratio of the area that lies between the line of equality and the Lorenz curve (marked A in the diagram) over the total area under the line of equality (marked A and B in the diagram); i.e., G = A/(A + B). It is also equal to 2A and to 1 − 2B due to the fact that A + B = 0.5 (since the axes scale from 0 to 1).

- 连续变量的熵计算（两种非参数估计方法）
    - 基于核密度估计方法
    - 基于K近邻估计方法