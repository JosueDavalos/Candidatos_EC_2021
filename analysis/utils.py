import matplotlib.pyplot as plt
import pandas as pd

def bar_plot(dict_values, title, ylabel, rotation=0):
    pd.Series(dict_values).plot(kind='bar', figsize=(16,5))
    plt.xticks(rotation=rotation)
    plt.ylabel(ylabel, size=14)
    plt.title(title, size=16)
    plt.grid(axis='y', alpha=.2)
    plt.show()