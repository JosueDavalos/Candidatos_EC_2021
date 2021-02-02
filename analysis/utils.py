import matplotlib.pyplot as plt
import pandas as pd
from wordcloud import WordCloud
from PIL import Image
import numpy as np
import re
from unicodedata import normalize
from nltk.corpus import stopwords

def bar_plot(dict_values, title, ylabel, rotation=0):
    pd.Series(dict_values).plot(kind='bar', figsize=(16,5))
    plt.xticks(rotation=rotation)
    plt.ylabel(ylabel, size=14)
    plt.title(title, size=16)
    plt.grid(axis='y', alpha=.2)
    plt.savefig("analysis/images/"+title+".png",dpi=200,bbox_inches='tight')
    plt.show()

def pie_sentiment_analysis(dict_sentiment_analysis, title):
    df = {'type': list(dict_sentiment_analysis.keys()), 'value': list(dict_sentiment_analysis.values())} 
    df = pd.DataFrame(df)
    plt.pie(df['value'], wedgeprops=dict(width=.4, edgecolor='w', alpha=.85), labeldistance=1.1,pctdistance=.8,
            autopct= lambda n: str(round((n/100.0)*100,1))+"%", startangle=45,labels=df.type, 
            colors=['#2bdb25','#ff795c','#f5bf42'])
    
    plt.title(title)
    plt.savefig("analysis/images/"+title+".png",dpi=200,bbox_inches='tight')
    plt.show()


def quitar_tildes(s):
    s = re.sub(r"([^n\u0300-\u036f]|n(?!\u0303(?![\u0300-\u036f])))[\u0300-\u036f]+", r"\1", 
               normalize( "NFD", s), 0, re.I)
    return normalize( 'NFC', s)

def get_stopwords_spanish():
    
    stopwords1 = set(pd.read_csv('analysis/stop_words_spanish.txt').iloc[:,0].to_list())
    stopwords1 =  stopwords1 | set(stopwords.words('spanish'))
    return {quitar_tildes (sw) for sw in stopwords1}


def get_wordcloud(list_serie_texto, social_networkd_name):
    serie_texto = []
    [serie_texto.extend(list(l_texto.apply(str))) for l_texto in list_serie_texto]

    #Limpiar Datasets
    raw_string = ' '.join(serie_texto)
    raw_string = quitar_tildes(raw_string)
    no_links = re.sub(r'http\S+', '', raw_string)
    no_unicode = re.sub(r"\\[a-z][a-z]?[0-9]+", '', no_links)
    no_special_characters = re.sub('[^A-Za-z0-9 ]+', '', no_unicode)
    words = no_special_characters.lower().split(' ')

    # Create stopword list:
    stopwords_spanish = get_stopwords_spanish()
    words = [w for w in words if w not in stopwords_spanish]

    
    mask = np.array(Image.open('analysis/ec.jpg'))
    plt.figure(figsize=(10, 14))
    wordcloud = WordCloud(stopwords = stopwords_spanish,
                        mask=mask, background_color="white",
                        max_words=700, max_font_size=256,
                        random_state=42, width=mask.shape[1],
                        height=mask.shape[0]).generate(','.join(words))

    plt.imshow(wordcloud, interpolation='bilinear')
    plt.axis("off")
    plt.title('WordCloud con todos los post de las redes sociales', size=15)
    plt.savefig('analysis/images/wordcloud_%s.png'%social_networkd_name,dpi=200,bbox_inches='tight')
    plt.show()


from deep_translator import GoogleTranslator

def tranlate_post_english(data, col_text, filename):
    translator = GoogleTranslator(source='spanish', target='en')
    data['en'] = data[col_text].apply(translator.translate)  
    data['en'] = data['en'].apply(str)
    data.to_csv('data/%s.csv'%filename, index=False)
    return data
   

