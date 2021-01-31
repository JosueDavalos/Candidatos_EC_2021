#%%
import pandas as pd
#%%
df=pd.read_csv("../data/comentarios-facebook.csv")
# %%
df.head()
# %%
usuarios = df["nombre"]
usuarios=usuarios.unique()
# %%
usuarios
#%%
df.describe()
#%%
df_unico=df.drop_duplicates(subset=["nombre","comentario"])
#%%
df_unico.head()
#%%
df_unico.describe()
#%%
df_unico.to_csv("comentarios_unicos.csv")