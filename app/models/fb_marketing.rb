class FBMarketing
  METRICS = {
    :impressions => FBMarketingImpression,
    :clicks => FBMarketingClick,
    :spent => FBMarketingSpent,
    :social_impressions => FBMarketingSocialImpression,
    :social_clicks => FBMarketingSocialClick,
    :social_spent => FBMarketingSocialSpent,
    :actions => FBMarketingAction,
    :unique_impressions => FBMarketingUniqueImpression,
    :unique_clicks => FBMarketingUniqueClick,
    :social_unique_impressions => FBMarketingSocialUniqueImpression,
    :social_unique_clicks => FBMarketingSocialUniqueClick,
    :connections => FBMarketingConnection
  }
  
  def self.auth?(data_source)
    Koala::Facebook::API.new(data_source.token)
  end
  
  def self.import_data(data_source)
    client = Koala::Facebook::API.new(data_source.token)
    
    until_date = Date.today.months_ago(1)
    since_date = until_date - 1.day
    first = true
    
    loop do
    
      if !first
        since_date = until_date
        until_date += 1.day
      end
      first = false
    
      adstats = client.get_connections(data_source.key, "stats",  {"since" => since_date.to_time.to_i, "until" => until_date.to_time.to_i})
    
      Rails.logger.debug { "adstats: #{adstats.inspect}" }

      #get result
      METRICS.each do | metric, chart |
        
        chart.destroy_all(:conditions => { :key => data_source.key, :date => until_date })
        
        #populate result and save 
        #TODO: check if metrics should be cast to string
        chart.create({:key => data_source.key, :date => until_date, metric => adstats[metric]})        
        
      end
      
      break if since_date > DateTime.now || until_date > DateTime.now
    end
    
  end # self.import_data
end
