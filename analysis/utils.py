import matplotlib.pyplot as plt
import pandas as pd
from wordcloud import WordCloud
from PIL import Image
import numpy as np
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


def get_stopwords_spanish():
    stopwords1 = set(pd.read_csv('analysis/stop_words_spanish.txt').iloc[:,0].to_list())
    stopwords1 =  stopwords1 | set(stopwords.words('spanish')) 
    return stopwords1


def get_wordcloud(serie_texto, social_networkd_name):
    mask = np.array(Image.open('analysis/ec.jpg'))
    plt.figure(figsize=(10, 14))

    # Create stopword list:
    stopwords_spanish = get_stopwords_spanish()
    texto = serie_texto.apply(lambda x: x.replace('\n',' ').replace('\r',' ').replace('#',' '))
    texto = texto.apply(lambda x: set(x.lower().split(' '))-stopwords_spanish).to_list()
    textt = []
    [textt.extend(list(review)) for review in texto]
    textt = ' '.join(textt).replace('http','').replace('.co','')

    wordcloud = WordCloud(stopwords = stopwords_spanish,
                        mask=mask, background_color="white",
                        max_words=500, max_font_size=256,
                        random_state=42, width=mask.shape[1],
                        height=mask.shape[0]).generate(textt)

    plt.imshow(wordcloud, interpolation='bilinear')
    plt.axis("off")
    plt.savefig('analysis/images/wordcloud_%s.png'%social_networkd_name,dpi=200,bbox_inches='tight')
    plt.show()