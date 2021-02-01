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

# %%
'''raw_edges=open("../data/edges.csv","w")
raw_edges.write("mencion,menciona_a\n")
#%%
for user in df_tweets["username"].unique():
    mencion_row=df_tweets[df_tweets["username"]==user]["mencions"]
    for mencion_lista in mencion_row:
        for mencion_to in mencion_lista:
            raw_edges.write(user+","+mencion_to.strip()+"\n")
            raw_edges.close()
print("Fin de archivo")'''
#%%
egdes = open("../data/graph.csv","r")
g = nx.DiGraph()
for linea in egdes:
    source,target,tipo,identificacion,label,time,weight = linea.split(",")
    g.add_edge(source,target, weigth=weight)
# %%
nx.draw(g, node_size=5,with_labels=True)
plt.show()
# %%
