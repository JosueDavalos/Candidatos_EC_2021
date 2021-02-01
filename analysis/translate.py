import pandas as pd
from utils import *

#translate texto
df = pd.read_csv('data/tweets_debate.csv').iloc[:7,:5].copy()
tranlate_post_english(df, 'texto','twitter_test_traducido')