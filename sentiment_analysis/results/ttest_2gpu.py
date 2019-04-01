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


sentiment_singularity_csv = '2GPU_sentiment_analysis_singularity.csv'
sentiment_native_csv = '2GPU_sentiment_analysis_native.csv'

native_df = pandas.read_csv(sentiment_native_csv, '\n', names=['Native Runtime (Seconds)'])
singularity_df = pandas.read_csv(sentiment_singularity_csv, '\n', names=['Singularity Runtime (Seconds)'])
native_df=native_df.drop([62,94,110])
#singularity_df=singularity_df.drop([18])
print(native_df.describe())
print(singularity_df.describe())
#df = native_df.merge(singularity_df, how='left')
#print(df.describe())
print('p-value:\t 0.05\n')
print('degrees of freedom:\t ~200\n')
print('Critical t-val:\t 1.980\n')

t_val_rel = stats.ttest_rel(native_df.loc[:,'Native Runtime (Seconds)'],singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_rel)
t_val_ind = stats.ttest_ind(native_df.loc[:,'Native Runtime (Seconds)'],singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_ind)

ax = plt.gca()

native_df.plot(kind='hist', y='Native Runtime (Seconds)', color='red', ax=ax)
singularity_df.plot(kind='hist', y='Singularity Runtime (Seconds)', color='blue', ax=ax)


plt.savefig('2gpu_Histogram.png')




