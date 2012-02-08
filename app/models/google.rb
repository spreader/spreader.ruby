class Google
  CHARTS = [GoogleVisit, GoogleAdclick, GoogleAdcost, GoogleCpc, GoogleCtr, GoogleImpression, GoogleMargin, GoogleRoi, GoogleRpc]
  
  def self.auth?(data_source)
    Garb::Session.login(data_source.username, data_source.passwd)    
  end
  
  def self.import_data(data_source)
    profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == data_source.key}
    #get result
    CHARTS.each do | chart |
      r = chart.results(profile)
      #populate result and save
      chart.destroy_all(:conditions => { :key => data_source.key })
      r.each do | data |
        values = {:key => data_source.key}
        chart.new.fields.each do | attr| 
          attr_name = attr.first
          next if ["_id", "key", "_type"].include?(attr_name)
          
          values[attr_name] = eval("data.#{attr_name}")
        end
        Rails.logger.info values.inspect
        chart.create(values)
        
      end      
    end
    
  end
end