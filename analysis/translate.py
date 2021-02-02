import pandas as pd
from utils import *

# #translate texto
# df = pd.read_csv('data/tweets_debate.csv').iloc[:7,:5].copy()
# tranlate_post_english(df, 'texto','twitter_test_traducido')

#translate texto
df_insta = pd.read_csv('data/InstagramRecientesUnicos.csv')
df_insta["texto"] = df_insta['texto'].astype(str)

df_instaD = pd.read_csv('data/InstagramDestacadosUnicos.csv')
df_instaD["texto"] = df_instaD['texto'].astype(str)


tranlate_post_english(df_insta, 'texto','insta_test_traducido_Recientes')

tranlate_post_english(df_instaD, 'texto','insta_test_traducido_Destacados')