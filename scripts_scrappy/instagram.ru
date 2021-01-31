require "selenium-webdriver"
require 'csv'

Selenium::WebDriver::Chrome.driver_path = "c:/users/zebas/downloads/chromedriver.exe"

links=['https://www.instagram.com/explore/tags/debatepresidencial/?hl=es-la','https://www.instagram.com/explore/tags/debatepresidencial2021/',
    'https://www.instagram.com/explore/tags/ecuadordebate2021/?hl=es-la',
    'https://www.instagram.com/explore/tags/cne/?hl=es-la',"https://www.instagram.com/explore/tags/elecciones2021ecuador/"]
driver = Selenium::WebDriver.for :chrome

driver.navigate.to 'https://www.instagram.com/'
sleep(1)
user = driver.find_element(:xpath, '//*[@id="loginForm"]/div/div[1]/div/label/input')
sleep(1)
user.send_keys "lpsebg"
sleep(1)

password = driver.find_element(:xpath, '//*[@id="loginForm"]/div/div[2]/div/label/input')
sleep(1)
password.send_keys "lp2021jsn"
sleep(1)
login = driver.find_element(:xpath, '//*[@id="loginForm"]/div/div[3]/button')
sleep(1)
login.click
sleep(15)
driver.navigate.to links[4]
puts "Scrapping %s" %[links[4]]
sleep(2)

# todos = driver.find_element(:xpath, '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[1]/div/div/span')
# todos.click
# sleep(5)
# newest = driver.find_element(:xpath,'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[2]/div/div/div[1]/div[1]/div/div/div[1]/div/div[1]/div/div[3]/div[1]')
# newest.click

# ESTRUCTURA DE POST DE INSTAGRAM
# 1. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[1]/div[1]/a/div[1]/div[1]/img
# 2. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[1]/div[2]/a/div[1]/div[1]/img
# 3. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[1]/div[3]/a/div[1]/div[1]/img
# 4. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[2]/div[1]/a/div[1]/div[1]/img
# 5. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[2]/div[2]/a/div[1]/div[1]/img
# 6. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[2]/div[3]/a/div[1]/div[1]/img
# 7. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[3]/div[1]/a/div[1]/div[1]/img
# 8. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[3]/div[2]/a/div[1]/div[1]/img
# 9. //*[@id="react-root"]/section/main/article/div[1]/div/div/div[3]/div[3]/a/div[1]/div[1]/img
# MAS RECIENTES
# 1. //*[@id="react-root"]/section/main/article/div[2]/div/div[1]/div[1]/a/div[1]/div[1]/img
# 2. //*[@id="react-root"]/section/main/article/div[2]/div/div[1]/div[2]/a/div[1]/div[1]/img
# 3. //*[@id="react-root"]/section/main/article/div[2]/div/div[1]/div[3]/a/div[1]/div[1]/img
# 5. //*[@id="react-root"]/section/main/article/div[2]/div/div[2]/div[2]/a/div[1]/div[1]/img
# 8. //*[@id="react-root"]/section/main/article/div[2]/div/div[3]/div[2]/a/div[1]/div[1]/img
#11. //*[@id="react-root"]/section/main/article/div[2]/div/div[4]/div[2]/a/div[1]/div[1]/img
# n. //*[@id="react-root"]/section/main/article/div[2]/div/div[8]/div[2]/a/div[1]/div[1]/img
# m. //*[@id="react-root"]/section/main/article/div[2]/div/div[9]/div[2]/a/div[1]/div[1]/img
#   //*[@id="react-root"]/section/main/article/div[2]/div/div[10]/div[1]/a/div/div[1]/img
#   //*[@id="react-root"]/section/main/article/div[2]/div/div[10]/div[2]/a/div/div[1]/img


# POP UP por cada PUBLICACION
# USER1 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/h2/div/span/a
# USER2 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/h2/div/span/a
# TAGS1 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/a[1]
# TAGS1 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/a[2]
# TAGS1 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/a[3]
# TAGS2 /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/a[1]
# TEXTO /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/text()[1]
# TEXTO /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span/text()
# CONTENEDOR UNIVERSAL /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span
# DATE /html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/div/div/time

countmatrix = 1
countrow = 0
# CSV.open('../data/instagramDestacados4.csv', 'a') do |csv|
#     csv <<["fecha","separador","user","separador","texto","separador","ubicacion"]
# end
for i in 1..3 do
    sleep(5)
    countrow=countrow+1
    
    xpath_postrow = '//*[@id="react-root"]/section/main/article/div[1]/div/div/div[%d]' %[countrow]
    countcol=0
    for j in 1..3 do 
        sleep(3)
        countcol=countcol+1
        xpath_postcolumn = '/div[%d]' %[countcol]
        begin
            post = driver.find_element(:xpath,xpath_postrow+xpath_postcolumn)
            post.click
            sleep(10)
            begin
                user = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/header/div[2]/div[1]/div[1]/span/a")
                sleep(2)
            rescue
                puts "user no funciona"
            end
            begin
                fecha = driver.find_element(:xpath, "/html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/div/div/time")
            rescue
                puts "fecha no funciona"
            end
            begin
                texto = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span")                
            rescue
                puts "texto no funciona"
            end
            begin
                ubicacion = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/header/div[2]/div[2]/div[2]/a")
                ubicacion = ubicacion.innerText
            rescue
                puts "ubicacion no funciona"
                ubicacion = "No data"
            end
            
            puts fecha.attribute("datetime")
            puts user.text
            puts texto.text
            puts ubicacion

            sleep(5)
            CSV.open('../data/instagramDestacados4.csv', 'a') do |csv|
                csv <<[fecha.attribute("datetime"),"|",user.text,"|",texto.text,"|",ubicacion]
            end
            sleep(5)
        rescue
            puts "No encontro comentario"
        end

        salir = driver.find_element(:xpath,"/html/body/div[5]/div[3]/button")
        salir.click
        sleep(5)
    end     
    puts "post %d" %[countrow]
    sleep(3)
    
end

driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
sleep(5)

countrow = 0

# CSV.open('../data/instagramRecientes4.csv', 'a') do |csv|
#     csv <<["fecha","separador","user","separador","texto","separador","ubicacion"]
# end
top = 15
while countrow<=1000
    sleep(3)

    countrow=countrow+1
    if countrow == top
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        sleep(5)
        countrow = countrow-5
    end  
    
    xpath_postrow = '//*[@id="react-root"]/section/main/article/div[2]/div/div[%d]' %[countrow]    
    countcol=0
    for i in 1..3 do
        countcol=countcol+1        
        xpath_postcolumn = '/div[%d]' %[countcol]
        begin
            post = driver.find_element(:xpath,xpath_postrow+xpath_postcolumn)
            post.click
            sleep(10)
            begin
                user = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/h2/div/span/a")
                sleep(2)
            rescue
                puts "user no funciona"
            end
            begin
                fecha = driver.find_element(:xpath, "/html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/div/div/time")
            rescue
                puts "fecha no funciona"
            end
            begin
                texto = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/div[3]/div[1]/ul/div/li/div/div/div[2]/span")
            rescue
                puts "texto no funciona"
            end
            begin
                ubicacion = driver.find_element(:xpath,"/html/body/div[5]/div[2]/div/article/header/div[2]/div[2]/div[2]/a")
                ubicacion = ubicacion.innerText
            rescue
                puts "ubicacion no funciona"
                ubicacion = "No data"
            end
            
            puts fecha.attribute("datetime")
            puts user.text
            puts texto.text
            puts ubicacion

            sleep(5)
            CSV.open('../data/instagramRecientes4.csv', 'a') do |csv|
                csv <<[fecha.attribute("datetime"),"|",user.text,"|",texto.text,"|",ubicacion]
            end
            sleep(5)
        rescue
            puts "No encontro comentario"
            
        end

        begin
            salir = driver.find_element(:xpath,"/html/body/div[5]/div[3]/button")        
            salir.click
            sleep(5)
        rescue
            puts "no hay boton"
            driver.navigate.to links[1]
        end

        driver.execute_script("window.scroll(0, 10)")
        puts "post %d" %[countrow] 
    end
    
    
end

driver.quit

puts "\nRecoleccion terminada..."
puts "====================================================="
