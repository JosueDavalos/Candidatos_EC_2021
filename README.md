# Candidatos_EC_2021
Análisis de los candidatos presidenciales del Ecuador 2021 en los días del debate presidenciales (16 y 17 de enero)

# Integrantes
- Josue Davalos: Twitter
- Nicole Agila: Facebook
- Sebastian Benalcazar: Instagram

# Tecnologías
- Extracción de datos: Ruby
- Analisís de datos: Python

# Instalación de dependencias.
## Twitter
Instalar API de Twitter En Ruby.
```
gem install twitter
```
Instalar dependencias para realizar el análisis de los tweets.
```
pip install -r requiments.txt
```
python -m nltk.downloader vader_lexicon
```
python -m nltk.downloader vader_lexicon
```

## Facebook
Instalar [Webdriver de Chrome xx.xx.xx](https://chromedriver.chromium.org/downloads) <br/>
Instalar Selenium para Ruby
```
gem install selenium-webdriver
```
Ingresar credenciales para login en facebook en el [script](https://github.com/JosueDavalos/Candidatos_EC_2021/blob/main/scripts_scrappy/facebook.rb)
```
user.send_keys "USUARIO"
password.send_keys "CONTRASENA"
```

## Instagram
Instalar [Webdriver de Chrome xx.xx.xx](https://chromedriver.chromium.org/downloads) <br/>
Instalar Selenium para Ruby
```
gem install selenium-webdriver
```
Ingresar credenciales para login en Instagram en el [script](https://github.com/JosueDavalos/Candidatos_EC_2021/blob/main/scripts_scrappy/instagram.rb)
```
user.send_keys "Usuario de Instagram"
password.send_keys "Contraseña de Instagram"
```
Para explorar cada uno de los TAGS ingresar los links de la búsqueda en el arreglo de links en el [script](https://github.com/JosueDavalos/Candidatos_EC_2021/blob/main/scripts_scrappy/instagram.rb)
