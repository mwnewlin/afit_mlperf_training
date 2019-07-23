# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import pandas as pd
import scipy
from scipy import stats
import matplotlib.pyplot as plt
import pandas
import random


sentiment_singularity_csv = '1xP100_sentiment_analysis_singularity.csv'
sentiment_native_csv = '1xP100_sentiment_analysis_native.csv'

native_df = pandas.read_csv(sentiment_native_csv, '\n', names=['Native Runtime (Seconds)'])
singularity_df = pandas.read_csv(sentiment_singularity_csv, '\n', names=['Singularity Runtime (Seconds)'])
print(native_df.describe())
print(singularity_df.describe())
native_df = native_df.drop([35])
singularity_df = singularity_df.drop([18])
sampled_native_df = native_df
sampled_singularity_df = singularity_df
#Randomly sample 30 of the data points from each run
count = len(sampled_native_df)
while (count > 30):
    random.seed(a=1)
    r = random.randint(0,count-1)
    sampled_native_df=sampled_native_df.drop(sampled_native_df.index[r])
    count = count-1
count2 = len(singularity_df)   
while (count2 > 30):
    random.seed(a=1)
    r = random.randint(0,count2-1)
    sampled_singularity_df=sampled_singularity_df.drop(sampled_singularity_df.index[r])  
    count2 = count2-1
print('After Sampling:\n')
print(sampled_native_df.describe())
print(sampled_singularity_df.describe())
#df = native_df.merge(singularity_df, how='left')
#print(df.describe())
print('p-value:\t 0.05\n')
print('degrees of freedom:\t ~60\n')
print('Critical t-val:\t 2.0\n')

t_val_rel = stats.ttest_rel(sampled_native_df.loc[:,'Native Runtime (Seconds)'],sampled_singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_rel)
t_val_ind = stats.ttest_ind(sampled_native_df.loc[:,'Native Runtime (Seconds)'],sampled_singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_ind)

fig1 = plt.figure(figsize=(5,5))
native_min = sampled_native_df['Native Runtime (Seconds)'].min()
native_max = sampled_native_df['Native Runtime (Seconds)'].max()
native_bins = np.linspace(native_min,native_max+1,10)
singularity_min = sampled_singularity_df['Singularity Runtime (Seconds)'].min()
singularity_max = sampled_singularity_df['Singularity Runtime (Seconds)'].max()
singularity_bins = np.linspace(singularity_min, singularity_max+1,10)
bins_best = np.linspace(150,300,15)
plt.hist(sampled_native_df['Native Runtime (Seconds)'], bins=bins_best, color='red', label='Native Runtime (Seconds)',
                           alpha=0.6, ec='black')
plt.hist(sampled_singularity_df['Singularity Runtime (Seconds)'],bins=bins_best, color='blue',
                                label='Singularity Runtime (Seconds)', alpha=0.6, ec='black')
plt.legend()


plt.savefig('P100_Histogram_rs.png')
plt.savefig('P100_Histogram_rs.eps')
plt.show()
"""
plt.figure(2)
ax2 = plt.gca()
native_df.plot(kind='hist', y='Native Runtime (Seconds)', color='red', ax=ax2)
singularity_df.plot(kind='hist', y='Singularity Runtime (Seconds)', color='blue', ax=ax2)
plt.savefig('P100_Histogram.png')
plt.savefig('P100_Histogram.eps')

"""

