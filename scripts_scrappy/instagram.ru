require "selenium-webdriver"
require 'csv'

Selenium::WebDriver::Chrome.driver_path = "c:/users/zebas/downloads/chromedriver.exe"

links=['https://www.instagram.com/explore/tags/debatepresidencial/?hl=es-la',
    'https://www.instagram.com/explore/tags/ecuadordebate2021/?hl=es-la',
    'https://www.instagram.com/explore/tags/cne/?hl=es-la']
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
driver.navigate.to links[1]
puts "Scrapping %s" %[links[1]]
sleep(2)
driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
sleep(5)
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
# countrow=0
# CSV.open('../data/instagramDestacados.csv', 'a') do |csv|
#     csv <<["texto","url-post"]
# end
# for i in 1..3 do
#     sleep(5)
#     countrow=countrow+1
#     xpath_postrow = '//*[@id="react-root"]/section/main/article/div[1]/div/div/div[%d]' %[countrow]
#     countcol=0
#     for j in 1..3 do 
#         sleep(3)
#         countcol=countcol+1
#         xpath_postcolumn = '/div[%d]/a/div[1]/div[1]/img' %[countcol]
#         begin
#             post = driver.find_element(:xpath,xpath_postrow+xpath_postcolumn)
#             CSV.open('../data/instagramDestacados.csv', 'a') do |csv|
#                 csv <<[post.attribute("alt"),post.attribute("src")]
#             end
#         rescue
#             puts "No encontro comentario"
#         end
#     end     
#     puts "post %d" %[countrow]
#     driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
#     sleep(5)
    
# end


countrow = 0

CSV.open('../data/instagramRecientes.csv', 'a') do |csv|
    csv <<["texto","url-post"]
end
while countrow<=1000
    sleep(3)
    if countmatrix==11
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
        sleep(5)
        countmatrix=5
    end
    countrow=countrow+1
    xpath_postrow = '//*[@id="react-root"]/section/main/article/div[2]/div/div[%d]' %[countrow]
    
    countcol=0
    for i in 1..3 do
        
        countcol=countcol+1        
        xpath_postcolumn = '/div[%d]/a/div[1]/div[1]/img' %[countcol]
        begin
            post = driver.find_element(:xpath,xpath_postrow+xpath_postcolumn)
            CSV.open('../data/instagramRecientes.csv', 'a') do |csv|
                csv <<[post.attribute("alt"),post.attribute("src")]
            end
        rescue
            puts "No encontro comentario"
        end
        puts "post %d" %[countrow] 
    end

    countmatrix = countmatrix+1
end

driver.quit

puts "\nRecoleccion terminada..."
puts "====================================================="
