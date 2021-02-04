import pandas as pd
from collections import Counter
from ast import literal_eval
from utils import bar_plot, pie_sentiment_analysis, get_wordcloud
import matplotlib.pyplot as plt
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import seaborn as sns
import numpy as np


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
dfDestacadosEn['fechaFormat'] = pd.to_datetime(dfDestacadosEn['fecha'])
dfRecientesEn['fechaFormat'] = pd.to_datetime(dfRecientesEn['fecha'])



dfDestacadosEn["sentimiento"] = dfDestacadosEn['texto'].apply(lambda i: sid.polarity_scores(i)["compound"])
print(dfDestacadosEn)
dfRecientesEn["sentimiento"] = dfRecientesEn['texto'].apply(lambda i: sid.polarity_scores(i)["compound"])
print(dfRecientesEn)



df_insta_Destacados = dfDestacadosEn.copy()[["fecha","fechaFormat", "sentimiento"]]
df_insta_Destacados['hora'] = df_insta_Destacados["fechaFormat"].dt.hour
df_insta_Destacados['dia'] = df_insta_Destacados["fechaFormat"].dt.day
df_insta_Destacados['mes'] = df_insta_Destacados["fechaFormat"].dt.month

df_insta_Recientes = dfRecientesEn.copy()[["fecha","fechaFormat", "sentimiento"]]
df_insta_Recientes['hora'] = df_insta_Recientes["fechaFormat"].dt.hour
df_insta_Recientes['dia'] = df_insta_Recientes["fechaFormat"].dt.day
df_insta_Recientes['mes'] = df_insta_Recientes["fechaFormat"].dt.month


# df_insta_Destacados.to_csv("InstagramDestacadosUnicos.csv")
del df_insta_Destacados["fechaFormat"]

# df_insta_Recientes.to_csv("InstagramRecientesUnicos.csv")
del df_insta_Recientes["fechaFormat"]

df_insta_Destacados.fecha=df_insta_Destacados.fecha.str[7:19]

df_insta_Recientes.fecha=df_insta_Recientes.fecha.str[7:19]

df_insta_Recientes.mes= df_insta_Recientes.mes.astype(int)

df_insta_Recientes = df_insta_Recientes[(df_insta_Recientes['mes'] == 1)]



# instaDestacados = df_insta_Destacados.pivot(index='fecha', columns='dia', values='sentimiento')
# instd = sns.heatmap(instaDestacados, vmin=-1, vmax=1)
# # instd.figure.savefig("HeatMapPostDestacadosPorDia.png")

# plt.title('Mapa de Calor Post por fecha según grado de aceptación')

# plt.savefig('HeatMapPostDestacadosPorDia.png')   



# instaRecientes = df_insta_Recientes.pivot(index='fecha', columns='dia', values='sentimiento')
# instr = sns.heatmap(instaRecientes, vmin=-1, vmax=1)
# # instr.figure.savefig("HeatMapPostRecientesPorDia.png")

# plt.title('Mapa de Calor Post por fecha según grado de aceptación')

# plt.savefig('HeatMapPostRecientesPorDia.png')   

df_ig = pd.read_csv("data/InstagramRecientesUnicos.csv")
df_ig['fecha'] = pd.to_datetime(df_ig['fecha'])
df_ig['hora'] = df_ig['fecha'].dt.hour

temp = df_ig.groupby(['dia','hora'], as_index=False)['sentimiento'].mean()
sns.heatmap(temp.pivot('dia','hora','sentimiento'), vmin=-1, vmax=1)
plt.title('Análisis de sentimientos por día y hora')
plt.savefig('AnalisisSentimientosPostPorDiaYHora.png')  
plt.show()





