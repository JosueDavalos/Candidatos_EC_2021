import pandas as pd

dfDestacados = pd.read_csv("../data/instagramDestacados.csv")
dfRecientes = pd.read_csv("../data/instagramRecientes.csv")

dfDestacadosU=dfDestacados.drop_duplicates(subset=["user","texto"])
dfRecientesU=dfRecientes.drop_duplicates(subset=["user","texto"])

del dfDestacadosU["separador"]
del dfDestacadosU["separador.1"]
del dfDestacadosU["separador.2"]
del dfRecientesU["separador"]
del dfRecientesU["separador.1"]
del dfRecientesU["separador.2"]

dfDestacadosU.to_csv("../data/InstagramDestacadosUnicos.csv")
dfRecientesU.to_csv("../data/InstagramRecientesUnicos.csv")


