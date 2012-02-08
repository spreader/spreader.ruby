class DashboardController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :js

  def graph
    app_id = params[:app_id]
    app_id ||= 313457693212
    #Rails.logger.error "SESSION ID #{session[:app_id]}"
    session[:app_id] = app_id unless !session[:app_id].nil?

    page_id = params[:id]
    graph_chart(page_id, "line", nil, nil, false)

    respond_with @graph

  end

  def chart_type
    app_id = params[:app_id]
    app_id ||= 313457693212
    session[:app_id] = app_id

    page_id = params[:id]
    chart_type = params[:chart_type]
    upload_data = params[:upload_data]
    date_range = params[:date_range]
    if date_range.nil? || date_range == ""
      @graph = graph_chart(page_id, chart_type, nil, nil, upload_data)
    else
      dates = date_range.split(" - ")
      to_date = DateTime.parse(dates[0])
      from_date = dates.length > 1 ? DateTime.parse(dates[1]) : DateTime.now
      @graph = graph_chart(page_id, chart_type, to_date, from_date, upload_data)
    end

    respond_with @graph
  end

  def feedback
    #@user_feedback = UserFeedback.new params[:user_feedback]
    feedback_comment = params[:feedback_comment]
    if !feedback_comment.nil?
      Feedback.new(:email => current_user.email, :comment => feedback_comment).save!
    end

    render :nothing => true
  end

  def friend_invite
    #@friend_invite = FriendInvite.new params[:friend_invite]
    friend_email = params[:friend_email]
    friend_name = params[:friend_name]
    friend_message = params[:friend_message]

    if !friend_email.nil? && !friend_name.nil?
      FriendInvite.new(:email => friend_email, :name => friend_name, :message => friend_message).save!
    end

    render :nothing => true
  end

  protected

  #@app_id = 313457693212
  #@app_id = 125524087493943
  def graph_chart page_id, chart_type, from_date, to_date, add_data
    lookup = {"page_comment_adds_unique" => {"title" => "Page Comment Adds (Unique)"}, "page_posts_impressions_unique" => {"title" => "Posts Impressions (Unique)"}, "page_posts_impressions" => {"title" => "Posts Impressions"}, "page_posts_impressions_paid_unique" => {"title" => "Posts Impressions Paid (Unique)"}, "page_posts_impressions_paid" => {"title" => "Posts Impressions Paid"}, "page_posts_impressions_organic_unique" => {"title" => "Posts Impressions Organic (Unique)"}, "page_posts_impressions_organic" => {"title" => "Posts Impressions Organic"}, "page_posts_impressions_viral_unique" => {"title" => "Posts Impressions Viral (Unique)"}, "page_posts_impressions_viral" => {"title" => "Posts Impressions Viral"}, "page_consumptions_unique" => {"title" => "Consumptions (Unique)"}, "page_consumptions" => {"title" => "Consumptions"}, "page_consumptions_by_consumption_type_unique" => {"title" => "Consumptions by Consumption Type (Unique)", "model" => "ConsumptionByType"}, "page_consumptions_by_consumption_type" => {"title" => "Consumptions by Consumption Type", "mode" => "ConsumptionByType"}, "page_fans_by_like_source_unique" => {"title" => "Fans by Like Source (Unique)", "model" => "FansByLikeSource"}, "page_fans_by_like_source" => {"title" => "Fans by Like Source", "model" => "FansByLikeSource"}, "page_fans" => {"title" => "Fans"}, "page_fans_locale" => {"title" => "Fans by Locale", "model" => "FansByLocale"}, "page_fans_city" => {"title" => "Fans by City", "model" => "FansByCity"}, "page_fans_country" => {"title" => "Fans by Country", "model" => "FansByCountry"}, "page_fans_gender" => {"title" => "Fans by Gender", "model" => "FansByGender"}, "page_fans_age" => {"title" => "Fans by Age", "model" => "FansByAge"}, "page_fans_gender_age" => {"title" => "Fans by Gender and Age", "model" => "FansByGenderAndGender"}, "page_friends_of_fans" => {"title" => "Friends of Fans"}, "page_active_users" => {"title" => "Active Users"}, "page_active_users_locale" => {"title" => "Active Users by Locale", "model" => "ActiveUsersByLocale"}, "page_active_users_city" => {"title" => "Active Users by City", "model" => "ActiveUsersByCity"}, "page_active_users_country" => {"title" => "Active Users by Country", "model" => "ActiveUsersByCountry"}, "page_active_users_gender" => {"title" => "Active Users by Gender", "model" => "ActiveUsersByGender"}, "page_active_users_age" => {"title" => "Active Users by Age", "model" => "ActiveUsersByAge"}, "page_active_users_gender_age" => {"title" => "Active Users by Gender and Age", "model" => "ActiveUsersByGenderAndAge"}, "page_storytellers" => {"title" => "Storytellers"}, "page_storytellers_by_story_type" => {"title" => "Storytellers by Story Type", "model" => "StorytellersByStoryType"}, "page_storytellers_by_age_gender" => {"title" => "Storytellers by Age and Gender", "model" => "StorytellersByAgeAndGender"}, "page_storytellers_by_country" => {"title" => "Storytellers by Country", "model" => "StorytellersByCountry"}, "page_storytellers_by_locale" => {"title" => "Storytellers by Locale", "model" => "StorytellersByLocale"}, "page_engaged_users" => {"title" => "Engaged Users"}, "page_impressions_frequency_distribution" => {"title" => "Impressions Frequency Distribution", "model" => "ImpressionsFrequencyDistribution"}, "page_impressions_viral_frequency_distribution" => {"title" => "Impressions Viral Frequency Distribution", "model" => "ImpressionsViralFrequencyDistribution"}, "page_posts_impressions_frequency_distribution" => {"title" => "Posts Impressions Frequency Distribution", "model" => "ImpressionsFrequencyDistribution"}, "page_views_unique" => {"title" => "Views (Unique)"}, "page_stories" => {"title" => "Stories"}, "page_stories_by_story_type" => {"title" => "Stories by Story Type", "model" => "StoriesByStoryType"}}
    upload_data = {DateTime.parse("1-Dec-11").to_time.to_i => 700, DateTime.parse("2-Dec-11").to_time.to_i => 700, DateTime.parse("3-Dec-11").to_time.to_i => 700, DateTime.parse("4-Dec-11").to_time.to_i => 700, DateTime.parse("5-Dec-11").to_time.to_i => 700, DateTime.parse("6-Dec-11").to_time.to_i => 700, DateTime.parse("7-Dec-11").to_time.to_i => 700, DateTime.parse("8-Dec-11").to_time.to_i => 950, DateTime.parse("9-Dec-11").to_time.to_i => 950, DateTime.parse("10-Dec-11").to_time.to_i => 950, DateTime.parse("11-Dec-11").to_time.to_i => 950, DateTime.parse("12-Dec-11").to_time.to_i => 950, DateTime.parse("13-Dec-11").to_time.to_i => 950, DateTime.parse("14-Dec-11").to_time.to_i => 950, DateTime.parse("15-Dec-11").to_time.to_i => 950, DateTime.parse("16-Dec-11").to_time.to_i => 950, DateTime.parse("17-Dec-11").to_time.to_i => 950, DateTime.parse("18-Dec-11").to_time.to_i => 950, DateTime.parse("19-Dec-11").to_time.to_i => 950, DateTime.parse("20-Dec-11").to_time.to_i => 200, DateTime.parse("21-Dec-11").to_time.to_i => 200, DateTime.parse("22-Dec-11").to_time.to_i => 200, DateTime.parse("23-Dec-11").to_time.to_i => 200, DateTime.parse("24-Dec-11").to_time.to_i => 200, DateTime.parse("25-Dec-11").to_time.to_i => 200, DateTime.parse("26-Dec-11").to_time.to_i => 200, DateTime.parse("27-Dec-11").to_time.to_i => 200, DateTime.parse("28-Dec-11").to_time.to_i => 200, DateTime.parse("29-Dec-11").to_time.to_i => 200, DateTime.parse("30-Dec-11").to_time.to_i => 200, DateTime.parse("31-Dec-11").to_time.to_i => 200, DateTime.parse("1-Jan-12").to_time.to_i => 200, DateTime.parse("2-Jan-12").to_time.to_i => 1500, DateTime.parse("3-Jan-12").to_time.to_i => 1500, DateTime.parse("4-Jan-12").to_time.to_i => 1500, DateTime.parse("5-Jan-12").to_time.to_i => 1500, DateTime.parse("6-Jan-12").to_time.to_i => 1500, DateTime.parse("7-Jan-12").to_time.to_i => 1500, DateTime.parse("8-Jan-12").to_time.to_i => 1500, DateTime.parse("9-Jan-12").to_time.to_i => 1500, DateTime.parse("10-Jan-12").to_time.to_i => 1500}

    page_id ||= lookup.first.key
    chart_type ||= "line"

    from_date ||= DateTime.now - 1.months
    to_date ||= DateTime.now

    Rails.logger.error "Session: #{session[:app_id]}"
    app_id = session[:app_id]

    results = Facebook.where(:app_id => app_id).and(:name => page_id).first
    #.and('values.end_date' => {'$gt' => from_date}).and('values.end_date' => {'$lt' => to_date})

    if results.nil?
      Rails.logger.error "Nothing found"
      flash[:error] = "Could not find data"
      return
    end

    title = lookup[page_id]["title"]
    model = lookup[page_id]["model"]
    if model.nil?
      model = "Generic"
    else
      model = "FacebookHash"
    end

    data = eval(model).new results['values']
    data.query to_date, from_date

    keys_and_values = {}
    data.items.each do |k, v|
      if model != "Generic"
        data.keys.each do |key|
          if keys_and_values.has_key?(key)
            values = keys_and_values[key]
            values.push [k, v[key]]
            keys_and_values[key] = values
          else
            keys_and_values[key] = [[k, v[key]]]
          end
        end
      else
        key = "value"
        if keys_and_values.has_key?(key)
          values = keys_and_values[key]
          values.push [k, v]
          keys_and_values[key] = values
        else
          keys_and_values[key] = [[k,v]]
        end
      end

    end

    @graph = LazyHighCharts::HighChart.new(page_id) do |f|
      f.chart :defaultSeriesType => "area", :zoomType => 'x'
      f.title({:text => "#{title} #{from_date.strftime("%d-%b-%y")} - #{to_date.strftime("%d-%b-%y")}"})
      f.global :useUTC => true
      f.legend(:align => "right", :floating => true, :verticalAlign => "top", :layout => "vertical", :backgroundColor => "#ddd" )

      f.plot_options :line => {:allowPointSelect => true, :cursor => "pointer", :dataLabels => {:enabled => true}},
                     :pie =>{:allowPointSelect => true, :cursor => "pointer", :dataLabels => {:enabled => true}, :showInLegend => false},
                     :area => {},
                     :lineWidth => 1,
                     :marker => {:enabled => false, :states => {:hover => {:enabled => true, :radius => 5}}},
                     :shadow => false,
                     :states => { :hover => { :lineWidth => 1 } }

      f.xAxis :type => "datetime", :pointInterval => 24 * 3600 * 1000, :pointStart => from_date.to_time.to_i, :dateTimeLabelFormats => { :month => '%e. %b', :day => '%b %e', :hour => '%b %e', :year => '%b' }

      keys_and_values.each do |k, v|
        f.series :yAxis => 0, :type => chart_type, :data => v, :name => k
      end
      f.yAxis :title => {:text => "#{title} Values"}, :min => 0

      if add_data
        f.yAxis :title => {:text => "Stocks Value"}, :opposite => true
        f.series :name => 'Stocks', :yAxis => 1, :type => chart_type, :data => upload_data.to_a
      end
    end

  end

end