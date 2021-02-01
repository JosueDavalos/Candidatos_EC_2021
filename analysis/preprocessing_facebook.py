import pandas as pd
df=pd.read_csv("../data/comentarios-facebook.csv")
usuarios = df["nombre"]
usuarios=usuarios.unique()
df_unico=df.drop_duplicates(subset=["nombre","comentario"])
df_unico.to_csv("comentarios_unicos.csv")