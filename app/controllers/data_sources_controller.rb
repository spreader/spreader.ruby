class DataSourcesController < ApplicationController
  inherit_resources
  
  expose(:ga_visitors)
  expose(:ga_impressions)
  expose(:ga_adclicks)
  expose(:ga_adcost)
  expose(:ga_cpc)
  expose(:ga_ctr)
  expose(:ga_margin)
  expose(:ga_roi)
  expose(:ga_rpc)
  
  expose(:youtube_views)
  expose(:youtube_comments)
  expose(:youtube_unique_users_30)
  expose(:youtube_favorites)
  
  expose(:fbm_impressions)
  expose(:fbm_clicks)
  expose(:fbm_spent)
  expose(:fbm_social_impressions)
  expose(:fbm_social_clicks)
  expose(:fbm_social_spent)
  expose(:fbm_actions)
  expose(:fbm_unique_impressions)
  expose(:fbm_unique_clicks)
  expose(:fbm_social_unique_impressions)
  expose(:fbm_social_unique_clicks)
  expose(:fbm_connections)
  
  def show
    render "#{resource.type.downcase}_show"
  end
  
  def ga_visitors
    dates, values = GoogleVisit.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Visitors"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Visits', :type=>"area", :data=>values)
      end
    return {}
  end

  def ga_impressions
    dates, values = GoogleImpression.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Impressions"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Impressions', :type=>"area", :data=>values)
      end
    return {}
  end
  
  def ga_adclicks
    dates, values = GoogleAdclick.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Ad Clicks"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Clicks', :type=>"area", :data=>values)
      end
    return {}
  end  

  def ga_adcost
    dates, values = GoogleAdcost.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Ad Cost"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Dollar $', :type=>"area", :data=>values)
      end
    return {}
  end  

  def ga_cpc
    dates, values = GoogleCpc.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Cost per Click"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Dollar $', :type=>"area", :data=>values)
      end
    return {}
  end  

  def ga_ctr
    dates, values = GoogleCtr.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Clickthrough rate"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Rate', :type=>"area", :data=>values)
      end
    return {}
  end  
  
  def ga_margin
    dates, values = GoogleMargin.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Margin"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Dollar $', :type=>"area", :data=>values)
      end
    return {}
  end  

  def ga_roi
    dates, values = GoogleMargin.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "ROI"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Dollar $', :type=>"area", :data=>values)
      end
    return {}
  end    

  def ga_rpc
    dates, values = GoogleRpc.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Revenue Per Click"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Dollar $', :type=>"area", :data=>values)
      end
    return {}
  end    

  def youtube_views
    dates, values = YoutubeChannelData.chart_data(resource.username)
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Views"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Views', :type=>"area", :data=>values)
      end
    return {}
  end


  def youtube_comments
    dates, values = YoutubeChannelData.chart_data(resource.username, "x", "comments")
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Comments"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Comments', :type=>"area", :data=>values)
      end
    return {}
  end  

  def youtube_unique_users_30
    dates, values = YoutubeChannelData.chart_data(resource.username, "x", "unique_users_30")
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Unique Users (30 days)"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Views', :type=>"area", :data=>values)
      end
    return {}
  end 
  
  def youtube_favorites
    dates, values = YoutubeChannelData.chart_data(resource.username, "x", "favorites")
    return LazyHighCharts::HighChart.new('graph') do |f|
        f.chart[:defaultSeriesType] = "area"
        f.title({:text => "Favorites"})
        f.xAxis(:categories => dates, :labels=>{:rotation=>-45, :align => 'right', :text => 'Date'})
        f.series(:name=>'Favorites', :type=>"area", :data=>values)
      end
    return {}
  end   
  
  #TODO: Refactor to some kind of metaprogramming to remove duplication, rescu on method_defined or define methods dynamically
  def fbm_impressions
    dates, values = FBMarketingImpression.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Impressions"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Impressions',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_clicks
    dates, values = FBMarketingClick.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Clicks"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Clicks',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_spent
    dates, values = FBMarketingSpent.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Spent"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Spent',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_social_impressions
    dates, values = FBMarketingSocialImpression.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Social impressions"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Social impressions',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_social_clicks
    dates, values = FBMarketingSocialClick.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Social clicks"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Social clicks',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_social_spent
    dates, values = FBMarketingSocialSpent.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Social spent"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Social spent',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_actions
    dates, values = FBMarketingAction.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Actions"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Actions',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_unique_impressions
    dates, values = FBMarketingUniqueImpression.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Unique impressions"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Unique impressions',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_unique_clicks
    dates, values = FBMarketingUniqueClick.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Unique clicks"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Unique clicks',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_social_unique_impressions
    dates, values = FBMarketingSocialUniqueImpression.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Social unique impressions"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Social unique impressions',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_social_unique_clicks
    dates, values = FBMarketingSocialUniqueClick.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Social unique clicks"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Social unique clicks',  :type=>"area", :data=>values)
    end
    return {}
  end
  
  def fbm_connections
    dates, values = FBMarketingConnection.chart_data(resource.key)
    return LazyHighCharts::HighChart.new('graph') do |f|
    f.chart[:defaultSeriesType] = "area"
    f.title({:text => "Connections"})
    f.xAxis(:categories => dates, :labels => {:rotation => -45, :align => 'right', :text => 'Date'})
    f.series(:name => 'Connections',  :type=>"area", :data=>values)
    end
    return {}
  end

end
