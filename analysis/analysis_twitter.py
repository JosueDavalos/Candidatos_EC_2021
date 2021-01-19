import pandas as pd
from collections import Counter
from textblob import TextBlob
from ast import literal_eval



def get_top(data, top=10):
    counts = Counter(data)
    return dict(sorted(dict(counts).items(), key=lambda kv: kv[1], reverse=True)[:top])


def get_mean_tweet_per_day(data):
    d = {}
    for day in ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']:
        d[day]=0
    data['day'] = data.index.day
    data['day_name'] = data.index.day_name()
    dict_temp = data.groupby(['day','day_name'], as_index=False)['texto'].count().groupby('day_name')['texto'].mean().to_dict()
    d.update(dict_temp)
    return d


def get_mean_tweet_per_hour(data):
    d = {}
    for i in range(24):
        d[i]=0
    data['hora'] = data.index.hour
    data['day'] = data.index.day
    dict_temp = data.groupby(['hora','day'], as_index=False)['texto'].count().groupby('hora')['texto'].mean().to_dict()
    d.update(dict_temp)
    return d


def get_amount_count_per_year(data):
    d = {}
    for i in range(2007,2021):
        d[i]=0
    data['create_count_year']= data['create_count'].dt.year
    d.update(data.groupby('create_count_year')['texto'].count().to_dict())
    return d

def get_sentiments(data):
    d = {'Positivo':0, 'Negativo':0, 'Neutral':0}
    temp = Counter(data['language'].to_list())
    languege = list(dict(sorted(dict(temp).items(), key=lambda kv: kv[1], reverse=True)[:1]).keys())[0]
    
    data['sentimiento'] = data['texto'].apply(lambda x: TextBlob(x).sentiment[0])
    data['sentimiento'] = data['sentimiento'].apply(lambda x: 'Positivo' if x>=0.45 else 'Negativo' if x<=-0.45 else 'Neutral'  )
    d.update((100*data.groupby('sentimiento')['texto'].count()/len(data)).to_dict())
    return d


def get_analysis(df_tweet):

    analysis = {
        'amount_tweets': len(df_tweet),
        'top_hashtag': get_top(df_tweet['hashtags'].sum()),
        'top_mencions': get_top(df_tweet['mencions'].sum()),
        'mean_tweet_per_hour': get_mean_tweet_per_hour(df_tweet),
        'mean_tweet_per_day': get_mean_tweet_per_day(df_tweet),
        'amount_count_per_year': get_amount_count_per_year(df_tweet),
        'sentiments': get_sentiments(df_tweet)
    }

    return analysis

df = pd.read_csv('data/tweets.csv')
df = pd.read_csv('data/tweets.csv')

df['fecha'] = pd.to_datetime(df['fecha'])
df['create_count'] = pd.to_datetime(df['create_count'])
df['hashtags'] = df['hashtags'].apply(literal_eval)
df['mencions'] = df['mencions'].apply(literal_eval)
df.set_index('fecha', inplace=True)

print(get_analysis(df))