require 'twitter'
require 'csv'


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "UMqWhrvhnvlriQjUGsEdeFBun"
  config.consumer_secret     = "wKqdKBJsntpqd03EmPEMfyMf4FZnGF05RbF2oG80MxgMAr9Kui"
  config.access_token        = "229639629-yXLcOQJlI9U8f6qqCStZtufUv9x3b2wqpwwdLsqW"
  config.access_token_secret = "rggSaGyuw6TOtfdg0tQsuXQAZdq6SIApeB5vs6Shv9wry"
end

tweets = client.filter(country='Ecuador', 
                        count: 99999999999999,
                        start_date = '16/01/2021',
                        end_date = '16/01/2021',
                        tweet_mode:'extended'
                      )
results = []
tweets.each do |t|
  long_tweet = client.status(t.id, tweet_mode: 'extended')
  fields = long_tweet.to_hash.slice(:created_at, :id, :full_text)
  tweet = fields.values
  results << tweet
end

csv = CSV.open("data/tweets.csv", "a+")
results.each do |r|
  csv << r
end