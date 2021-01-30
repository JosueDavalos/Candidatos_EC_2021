require 'twitter'
require 'csv'


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "UMqWhrvhnvlriQjUGsEdeFBun"
  config.consumer_secret     = "wKqdKBJsntpqd03EmPEMfyMf4FZnGF05RbF2oG80MxgMAr9Kui"
  config.access_token        = "229639629-yXLcOQJlI9U8f6qqCStZtufUv9x3b2wqpwwdLsqW"
  config.access_token_secret = "rggSaGyuw6TOtfdg0tQsuXQAZdq6SIApeB5vs6Shv9wry"
end

#place: code_country 4e43cac8250a8b20
tweets = client.search("place:4e43cac8250a8b20",).take(9)

results = []
tweets.each do |t|
  long_tweet = client.status(t.id, tweet_mode: 'extended')
  fields = long_tweet.to_hash.slice(:created_at, 
                                    :full_text,
                                    :retweet_count,
                                    :favorite_count,
                                    :place,
                                    :entities,
                                    :user
                                    )
  tweet = fields.values
  info_place = [nil,nil,nil]
  
  if tweet[-3] != nil 
    info_place = tweet[-3].to_hash.slice(:name,
                                    :full_name,
                                    :country
                                    ).values
  end 

  info_user = tweet[-1].to_hash.slice(:screen_name,
                                    :followers_count,
                                    :friends_count,
                                    :created_at
                                    ).values

  info_entities = tweet[-2].to_hash.slice(:hashtags,
                                          :user_mentions
                                          ).values

  hashtags = []
  info_entities[0].each do |hashtag|
    hashtag = hashtag.to_hash.slice(:text).values[0]
    hashtags << hashtag
  end

  mentions = []
  info_entities[1].each do |mention|
    mention = mention.to_hash.slice(:screen_name).values[0]
    mentions << mention
  end

  tweet = tweet.slice(0,4) + [hashtags] + [mentions] + info_place + info_user 
  results << tweet
end                 


csv = CSV.open("data/tweets3.csv", "wb")
header = ["fecha","texto",'retweet_count','favorite_count','hashtags','mencions','name_place','full_name_place','country','username','followers','friends','create_count']
csv << header
results.each do |r|
  csv << r
end




