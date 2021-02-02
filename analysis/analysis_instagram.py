import pandas as pd
from collections import Counter
from ast import literal_eval
from utils import bar_plot, pie_sentiment_analysis, get_wordcloud
import matplotlib.pyplot as plt
from nltk.sentiment.vader import SentimentIntensityAnalyzer


# dfDestacados = pd.read_csv("data/instagramDestacados.csv")
# dfRecientes = pd.read_csv("data/instagramRecientes.csv")

# dfDestacadosU=dfDestacados.drop_duplicates(subset=["user","texto"])
# dfRecientesU=dfRecientes.drop_duplicates(subset=["user","texto"])

# del dfDestacadosU["separador"]
# del dfDestacadosU["separador.1"]
# del dfDestacadosU["separador.2"]
# del dfRecientesU["separador"]
# del dfRecientesU["separador.1"]
# del dfRecientesU["separador.2"]

# dfDestacadosU.to_csv("InstagramDestacadosUnicos.csv")
# dfRecientesU.to_csv("InstagramRecientesUnicos.csv")


# dfDestacadosU['texto'] = dfDestacadosU['texto'].astype(str)
# dfRecientesU['texto'] = dfRecientesU['texto'].astype(str)



# get_wordcloud([dfDestacadosU.texto], 'Instagram Destacados')
# get_wordcloud([dfRecientesU.texto], 'Instagram Recientes')


dfDestacadosEn = pd.read_csv("data/insta_test_traducido_Destacados.csv")
dfRecientesEn = pd.read_csv("data/insta_test_traducido_Recientes.csv")

sid = SentimentIntensityAnalyzer()
dfDestacadosEn['texto'] = dfDestacadosEn['texto'].astype(str)
dfRecientesEn['texto'] = dfRecientesEn['texto'].astype(str)
dfDestacadosEn['fecha'] = pd.to_datetime(dfDestacadosEn['fecha'])
dfRecientesEn['fecha'] = pd.to_datetime(dfRecientesEn['fecha'])



dfDestacadosEn["sentimiento"] = dfDestacadosEn['texto'].apply(lambda i: sid.polarity_scores(i)["compound"])
print(dfDestacadosEn)
dfRecientesEn["sentimiento"] = dfRecientesEn['texto'].apply(lambda i: sid.polarity_scores(i)["compound"])
print(dfRecientesEn)

df_insta_Destacados = dfDestacadosEn.copy()
df_insta_Destacados['dia'] = df_insta_Destacados["fecha"].dt.day
# group by month and year, get the average
df_insta_Destacados.to_csv("InstagramDestacadosUnicos.csv")
df_insta_Destacados = df_insta_Destacados.groupby(['dia'])

df_insta_Recientes = dfRecientesEn.copy()
df_insta_Recientes['dia'] = df_insta_Recientes["fecha"].dt.day
# group by month and year, get the average
df_insta_Recientes.to_csv("InstagramRecientesUnicos.csv")
df_insta_Recientes = df_insta_Recientes.groupby(['dia'])

