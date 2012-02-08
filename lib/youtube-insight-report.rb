require 'net/http'
require 'uri'
require 'cgi'
require 'json'
require 'date'

# Provide a `dig' method to Hash
# objects which makes traversing them
# easier.
class Hash
  def dig(*path)
    path.inject(self) do |location, key|
      if location.respond_to?(:keys)
        location[key]
      elsif location.respond_to?(:at) && key.is_a?(Integer)
        location.at(key)
      else
        nil
      end
    end
  end
end

# Takes a date string, and parses it into the
# form requested with `type`. Beware evil
# recursion.
def parse_date (str, type=nil)
  case type
  when :hyph
    parse_date(str, :date).to_s
  when :rhyph
    Time.at(parse_date(str, :time)).to_s[0..9]
  when :secs
    parse_date(str, :time).to_i
  when :secs_str
    parse_date(str, :secs).to_s
  when :msecs
    parse_date(str, :secs)*1000
  when :msecs_str
    parse_date(str, :msecs).to_s
  when :date
    Date.parse(str)
  when :time
    parse_date(str, :date).to_time
  else
    str
  end
end

# # YoutubeInsightReport -- a wrapper class for the
# # YouTube Insights API. Use it like this:
#
# yir = YoutubeInsightReport.new({
#   :app_name      => '{YOUR_APP_NAME}',
#   :developer_key => '{YOUR_DEVELOPER_KEY}',
#   :email_address => '{YOUR_EMAIL_ADDRESS}',
#   :password      => '{YOUR_ACCOUNT_PASSWORD}'
# })
# 
# # Once the object is instantiated, you can do this:
# 
# zip = yir.retrieve({
#   :video_id   => '{VIDEO_ID}',
#   :start_date => '{START_DATE}',
#   :end_date   => '{END_DATE}'
# })
# 
# # `zip' will contain the path to a .zip archive
# # which you can extract on your own.
# 
# 
class YoutubeInsightReport
  attr_reader :developer_key, 
              :email_address,
              :password,
              :app_name,
              :video_id,
              :authorization_key,
              :video_entry,
              :insight_path,
              :start_date,
              :end_date,
              :archive
  
  # Instantiate a new YoutubeInsightReport object.
  # With the constructor arguments we have enough info to
  # authorize ourselves to retrieve Insight reports
  # from an account for any video we own.
  def initialize (credentials = {})
    @app_name      = credentials[:app_name]
    @developer_key = credentials[:developer_key]
    @email_address = credentials[:email_address]
    @password      = credentials[:password]
    Rails.logger.info "YouTube Insight Report initialized."
  end
  
  def retrieve_clientlogin_authorization_key
    Rails.logger.info "Retrieving ClientLogin authorization key ..."

    # Build query
    path = "https://www.google.com:443/accounts/ClientLogin"
    query_params = [
      "Email=#{@email_address}",
      "Passwd=#{@password}",
      "service=youtube",
      "source=#{@app_name}"
    ]
    data = query_params.join('&')
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
    uri = URI.parse(path)
    
    # Send POST request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    resp, data = http.post(path, data, headers)
    
    # Parse response
    auth_keypair = data.match(/Auth=.*\n/)[0]
    auth_key     = auth_keypair.gsub("Auth=", "").chomp
    
    # Return ClientLogin authorization key
    return auth_key
  end
  
  def retrieve_video_entry (account = {})
    Rails.logger.info "Retrieving video entry object ..."

    video_id          = account[:video_id]
    developer_key     = account[:developer_key]
    authorization_key = account[:authorization_key]
    
    # Build query
    query_params = [
      "q=#{video_id}",
      "v=2",
      "key=#{developer_key}",
      "alt=json"
    ]
    query_string = query_params.join('&')
    path = "https://gdata.youtube.com/feeds/api/videos?#{query_string}"
    uri = URI.parse(path)
    
    # Send GET request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "GoogleLogin auth=#{authorization_key}"
    request["X-GData-Key"] = "key=#{developer_key}"
    resp, data = http.request(request)

    # Return video entry object
    return data
  end
  
  def return_insight_path
    Rails.logger.info "Extracting the video's Insight report path ..."

    # Parse the video entry data into a Hash object
    json = JSON.parse(@video_entry)
    link_rel = "http://gdata.youtube.com/schemas/2007#insight.views"
    
    # Grab the node that contains the link to the
    # YouTube Insights data
    link_struct = {}
    json.dig("feed", "entry", 0, "link").each do |link|
      if link.dig("rel") == link_rel
        link_struct = link
      end
    end
    href = link_struct["href"]

    # Return the complete reference location
    return href
  end

  def return_insight_query (options = {})
    Rails.logger.info "Building Insight query ..."

    start_date = options[:start_date]
    end_date   = options[:end_date]

    
    # Parse the query so we can set the params
    path_parsed  = URI.parse(@insight_path)
    query_parsed = CGI.parse(path_parsed.query)

    # Set the date params according to the user's request
    query_parsed["starttime"] = [parse_date(start_date, :msecs_str)]
    query_parsed["endtime"]   = [parse_date(end_date, :msecs_str)]

    # Build an actual query string out of this object
    query_string = query_parsed.map do |name, values|
      values.map do |value|
        "#{CGI.escape name}=#{CGI.escape value}"
      end
    end.flatten.join('&')

    # Return the complete path to the Insights report
    partial_path = "http://insight.youtube.com/video-analytics/csvreports?"
    return partial_path + query_string
  end

  def retrieve_insight_zip_file (location)
    Rails.logger.info "Retrieving Insight report [this may take a moment] ..."

    # Set the location we're getting the report from,
    # and the location we're going to save it to.
    remote_path = location
    save_path   = "tmp/" +
                  "#{@video_id}_#{@start_date}-#{@end_date}.zip"
    
    # Build the request
    uri = URI.parse(remote_path)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Authorization"] = "GoogleLogin auth=#{@authorization_key}"
    request["X-GData-Key"] = "key=#{@developer_key}"
    resp, data = http.request(request)

    # Save the response
    open(save_path, 'w') do |file|
      file.write(resp.body)
    end

    # Return the path of the saved archive
    return save_path
  end
  
  # `retrieve' will make a request to the YouTube Insight API
  # for a report for a single video (using the specified video's ID)
  # over the date range specified. YouTube may restrict date ranges
  # to a particular size.
  def retrieve (metrics = {})
    @video_id   = metrics[:video_id]
    @start_date = metrics[:start_date]
    @end_date   = metrics[:end_date]

    # Get the ClientLogin authorization key
    @authorization_key = retrieve_clientlogin_authorization_key

    # Get a "video entry" object from YouTube
    @video_entry = retrieve_video_entry({
      :video_id          => @video_id,
      :developer_key     => @developer_key,
      :authorization_key => @authorization_key
    })

    # Extract the path to this video's Insight report
    @insight_path  = return_insight_path
    Rails.logger.info @insight_path.inspect
    # Build a query for the specified date range
#    @insight_query = return_insight_query({
#      :start_date => @start_date,
#      :end_date   => @end_date
#    })
#    Rails.logger.info @insight_query.inspect
    # Retrieve the remote archive, save it locally
    @archive       = retrieve_insight_zip_file(@insight_path)

    # Acknowledge success and return the file path
    Rails.logger.info "Retrieved report!:\n#{@archive}"
    return @archive
  end
end