from utils import get_sentiments, bar_plot, pie_sentiment_analysis
import pandas as pd

def complete_hour(s):
    l = s.split(':')
    n = len(l)
    if n==3:
        return s
    return ':'.join(['00']+l)

df_fb = pd.read_csv("data/comentarios_unicos.csv")
df_fb['minuto'] = df_fb['minuto'].apply(complete_hour)
df_fb['minuto'] = pd.to_datetime(df_fb['minuto'], format="%H:%M:%S")
df_fb.set_index('minuto', inplace=True)

top_times = df_fb.resample('60s').count().sort_values('comentario', ascending=False).head(10)
top_times['tiempo'] = top_times.index.strftime('%H:%M:%S')
top_tiempos = top_times[['tiempo','comentario']].set_index('tiempo').to_dict()['comentario']

bar_plot(top_tiempos, 'Top 10 de los tiempos con mayor cantidad de comentarios - Facebook', 'Comentarios')

sentiments_arauz = get_sentiments(df_fb[df_fb['comentario'].astype(str).str.contains('arauz')].copy(), 'en')
pie_sentiment_analysis(sentiments_arauz, 'Análisis de Sentimientos en Facebook sobre Arauz')
