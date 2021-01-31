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
Instalar API de Twitter.
```
gem install twitter
```
## Facebook
Instalar [Webdriver de Chrome xx.xx.xx](https://chromedriver.chromium.org/downloads) <br/>
Instalar Selenium para Ruby
```
gem install selenium-webdriver
pip install deep-translator
pip install googletrans
googletrans==3.1.0a0
```
Ingresar credenciales para login en facebook en el [script](https://github.com/JosueDavalos/Candidatos_EC_2021/blob/main/scripts_scrappy/facebook.rb)
```
user.send_keys "USUARIO"
password.send_keys "CONTRASENA"
```
