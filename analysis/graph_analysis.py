#%%
import networkx as nx
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
#%%
df_tweets = pd.read_csv("../data/tweets_debate.csv")
df_tweets=df_tweets[["username","texto","hashtags","mencions"]]
# %%
df_tweets = df_tweets.apply(lambda x : None if x["mencions"]=="[]" else x ,axis=1)
df_tweets = df_tweets.dropna()
# %%
df_tweets["mencions"]=df_tweets["mencions"].apply(lambda x: x.replace("[","").replace("]","").replace("'","").split(",") )
#%%
'''df_tweets.head()'''
# %%
'''menciones_enlista = df_tweets["mencions"]'''
#%%
'''menciones = set()
for mencion_to in menciones_enlista:
    for j in mencion_to:
        menciones.add(j.strip())
menciones=list(menciones)'''
# %%
g = nx.DiGraph()
#%%
for user in df_tweets["username"].unique():
    mencion_row=df_tweets[df_tweets["username"]==user]["mencions"]
    for mencion_lista in mencion_row:
        for mencion_to in mencion_lista:
            g.add_edge(user,mencion_to.strip(), weigth=1)
#%%
plt.hist([v for k,v in nx.degree(g)]);
plt.show()
# %%
nx.draw(g, node_size=2)
plt.show()
# %%
