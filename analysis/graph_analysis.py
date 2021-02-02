import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt
import numpy as np
from utils import get_wordcloud

def preprocessing_comments():
    df=pd.read_csv("../data/comentarios-facebook.csv")
    usuarios = df["nombre"]
    usuarios=usuarios.unique()
    df_unico=df.drop_duplicates(subset=["nombre","comentario"])
    df_unico.to_csv("comentarios_unicos.csv")

#preprocessing_comments()

def clean_tweets_mentions():
    df_tweets=df_tweets[["username","texto","hashtags","mencions"]]
    df_tweets = df_tweets.apply(lambda x : None if x["mencions"]=="[]" else x ,axis=1)
    df_tweets = df_tweets.dropna()
    df_tweets["mencions"]=df_tweets["mencions"].apply(lambda x: x.replace("[","").replace("]","").replace("'","").split(",") )

def edges_file():
    raw_edges=open("../data/edges.csv","w")
    raw_edges.write("mencion,menciona_a\n")
    for user in df_tweets["username"].unique():
        mencion_row=df_tweets[df_tweets["username"]==user]["mencions"]
        for mencion_lista in mencion_row:
            for mencion_to in mencion_lista:
                raw_edges.write(user+","+mencion_to.strip()+"\n")
                raw_edges.close()
    print("Fin de archivo")

def nodes_edges():
  edges=pd.read_csv("../data/graph.csv")
  nodes = pd.read_csv("../data/nodes.csv")
  return edges,nodes

def create_graph():
  g=nx.from_pandas_edgelist(edges,source="Source",target="Target")
  pos = nx.spring_layout(g)
  ec = nx.draw_networkx_edges(g, pos, alpha=0.2)
  nc = nx.draw_networkx_nodes(g, pos, node_size=100, cmap=plt.cm.jet)
  plt.show()


df_tweets = pd.read_csv("../data/tweets_debate.csv")
#clean_tweets_mentions()
#edges_file()
edges,nodes=nodes_edges()
#create_graph()

nodes = nodes.sort_values('indegree',ascending=False)
plt.bar(nodes["Id"].head(),nodes["indegree"].head(), color="lightcoral")
plt.ylabel("indegree")
#plt.savefig('/images/indegree.png')
plt.show()

nodes = nodes.sort_values('betweenesscentrality',ascending=False)
plt.bar(nodes["Id"].head(),nodes["betweenesscentrality"].head(), color="moccasin")
plt.ylabel("betweenesscentrality")
#plt.savefig('/images/betweenesscentrality.png')
plt.show()

nodes['freq_class']=nodes.groupby("modularity_class")["modularity_class"].transform("count")
nodes=nodes.drop_duplicates(subset=["modularity_class"])
nodes = nodes.sort_values('freq_class',ascending=False)
top_class = nodes.head()["freq_class"].values
for c in top_class:
    get_wordcloud([nodes[nodes["modularity_class"]==c].Id], 'class_{}'.format(c))