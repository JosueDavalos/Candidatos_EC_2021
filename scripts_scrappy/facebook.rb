require "selenium-webdriver"
require 'csv'

Selenium::WebDriver::Chrome.driver_path = "/home/nagila/Downloads/Instaladores/chromedriver_linux64/chromedriver"

links=['https://www.facebook.com/watch/live/?v=413121536672001&ref=watch_permalink','https://www.facebook.com/watch/live/?v=198091908699961&ref=search','https://www.facebook.com/watch/live/?v=327639468467607&ref=search','https://www.facebook.com/watch/live/?v=337713537604525&ref=watch_permalink']
driver = Selenium::WebDriver.for :chrome

driver.navigate.to 'https://www.facebook.com/?stype=lo&jlou=Afefo62Fe2jNt7zpIyqNvYVAuGiI42rSx8M4rASi0mdnEAFH-IP5yzZiyVegBlN1MtkaiQP9wiUnJr6RdbGaUE1Ld2RpsvC-CB9hfUtuGHsqTg&smuh=30675&lh=Ac_r7xLse5WG52XtObI'
sleep(2)
user = driver.find_element(:xpath, '//*[@id="email"]')
sleep(2)
user.send_keys ""
sleep(2)
password = driver.find_element(:xpath, '//*[@id="pass"]')
sleep(2)
password.send_keys ""
sleep(2)
login = driver.find_element(:xpath, '//*[@id="u_0_b"]')
sleep(2)
login.click
sleep(10)
driver.navigate.to links[2]
puts "Scrapping %s" %[links[2]]
sleep(10)
ver_comments = driver.find_element(:xpath, '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div/div/div[1]/div/span[2]/div')
ver_comments.click
sleep(5)
todos = driver.find_element(:xpath, '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[1]/div/div/span')
todos.click
sleep(5)
newest = driver.find_element(:xpath,'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[2]/div/div/div[1]/div[1]/div/div/div[1]/div/div[1]/div/div[3]/div[1]')
newest.click

count=0
CSV.open('../data/comentarios-facebook.csv', 'a') do |csv|
    csv <<["nombre","minuto","comentario","url-perfil"]
end
for i in 1..2 do
    sleep(2)
    count=count+1
    xpath_hora = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/span/span[2]/div' %[count]
    xpath_comment='//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/div[2]/span/div/div' %[count]
    xpath_nombre = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div/div/div/div[1]/a/span/span' %[count]
    xpath_perfil = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div/div/div/div[1]/a' %[count]
    puts "Comentario %d" %[count]

    begin
        comment = driver.find_element(:xpath,xpath_comment)
        hora = driver.find_element(:xpath, xpath_hora)
        nombre = driver.find_element(:xpath,xpath_nombre)
        perfil = driver.find_element(:xpath,xpath_perfil)
        CSV.open('../data/comentarios-facebook.csv', 'a') do |csv|
            csv <<[nombre.text,hora.text,comment.text,perfil.attribute("href")]
        end
    rescue
        puts "No encontro comentario"
    end
    
end

while count<=11718
    begin
        more = driver.find_element(:xpath,'//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/div[2]/div[1]/div[2]/span/span')
        sleep(2)
        more.click
    rescue
        puts "No encontro opcion de mas comentarios"
    end

    for i in 1..4 do
        sleep(2)
        count=count+1
        xpath_hora = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/span/span[2]/div' %[count]
        xpath_comment='//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div[1]/div/div/div[2]/span/div/div' %[count]
        xpath_nombre = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div/div/div/div[1]/a/span/span' %[count]
        xpath_perfil = '//*[@id="mount_0_0"]/div/div[1]/div[1]/div[3]/div/div/div[1]/div[1]/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div[2]/ul/li[%d]/div[1]/div/div[2]/div/div[1]/div/div/div/div/div[1]/a' %[count]
        puts "Comentario %d" %[count]
        begin
            comment = driver.find_element(:xpath,xpath_comment)
            hora = driver.find_element(:xpath, xpath_hora)
            nombre = driver.find_element(:xpath,xpath_nombre)
            perfil = driver.find_element(:xpath,xpath_perfil)
            CSV.open('../data/comentarios-facebook.csv', 'a') do |csv|
                csv <<[nombre.text,hora.text,comment.text,perfil.attribute("href")]
            end
        rescue
            puts "No encontro comentario"
        end
        
    end    
end

driver.quit

puts "\nRecoleccion terminada..."
puts "====================================================="
