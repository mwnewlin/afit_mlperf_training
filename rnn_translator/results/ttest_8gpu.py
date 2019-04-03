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


sentiment_singularity_csv = '8GPU_rnn_translator_singularity.csv'
sentiment_native_csv = '8GPU_rnn_translator_native.csv'

native_df = pandas.read_csv(sentiment_native_csv, '\n', names=['Native Runtime (Seconds)'])
singularity_df = pandas.read_csv(sentiment_singularity_csv, '\n', names=['Singularity Runtime (Seconds)'])
#Drop lowest 2 and highest 2 values from native to match sample sizes
native_df = native_df.drop([13,23,25,26])
print(native_df.describe())
print(singularity_df.describe())

#print(df.describe())
print('p-value:\t 0.05\n')
#DF = 27+27-2 = 52
print('degrees of freedom:\t ~50\n')
#Critical Val for DF = 50: 2.01
print('Critical t-val:\t 2.01\n')

t_val_rel = stats.ttest_rel(native_df.loc[:,'Native Runtime (Seconds)'],singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_rel)
t_val_ind = stats.ttest_ind(native_df.loc[:,'Native Runtime (Seconds)'],singularity_df.loc[:,'Singularity Runtime (Seconds)'])
print(t_val_ind)

ax = plt.gca()

native_df.plot(kind='hist', y='Native Runtime (Seconds)', color='red', ax=ax)
singularity_df.plot(kind='hist', y='Singularity Runtime (Seconds)', color='blue', ax=ax)


plt.savefig('rnn_translator_8gpu_Histogram.png')




