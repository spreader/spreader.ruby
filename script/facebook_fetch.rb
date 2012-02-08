require 'facebook'

class FacebookFetch

  def initialize
    config = {'app_id' => 313457693212, 'secret' => '9725e6e77e07a48e4cb45fe56c7fc2db', 'token' => 'AAACEdEose0cBAOdInaZBaX3ZCElTb3SqJGnYoVffowEIBGQDnNDNmzN13iGZCWr2ekW8ZCXWG2yZCMm8PRkf61vHd2usZB17IZD'}
  end

  def fetch
    config = {'app_id' => 313457693212, 'secret' => '9725e6e77e07a48e4cb45fe56c7fc2db', 'token' => 'AAACEdEose0cBAOdInaZBaX3ZCElTb3SqJGnYoVffowEIBGQDnNDNmzN13iGZCWr2ekW8ZCXWG2yZCMm8PRkf61vHd2usZB17IZD'}
    client = Koala::Facebook::API.new(config['token'])

    names = ["page_fan_adds_unique", "page_fan_adds", "page_fan_removes_unique", "page_fan_removes", "page_fan_adds_source_unique", "page_fan_adds_source", "page_fan_removes_source_unique", "page_fan_removes_source", "page_comment_adds_unique", "page_comment_adds", "page_comment_removes_unique", "page_comment_removes", "page_comment_adds_source_unique", "page_comment_adds_source", "page_comment_removes_source_unique", "page_comment_removes_source", "page_discussions_unique", "page_discussions", "page_like_adds_unique", "page_like_adds", "page_like_removes_unique", "page_like_removes", "page_like_adds_source_unique", "page_like_adds_source", "page_like_removes_source_unique", "page_like_removes_source", "page_review_adds_unique", "page_review_adds", "page_review_modifications_unique", "page_review_modifications", "page_photos_unique", "page_photos", "page_videos_unique", "page_videos", "page_wall_posts_unique", "page_wall_posts", "page_wall_posts_source_unique", "page_wall_posts_source", "page_photo_views_unique", "page_photo_views", "page_video_plays_unique", "page_video_plays", "page_audio_plays_unique", "page_audio_plays", "page_views_login_unique", "page_views_login_unique", "page_views_login", "page_views_login", "page_views_logout", "page_views", "page_tab_views_login_top_unique", "page_tab_views_login_top_unique", "page_tab_views_login_top", "page_tab_views_login_top", "page_tab_views_logout_top", "page_views_internal_referrals", "page_views_external_referrals", "page_stream_views_unique", "page_stream_views", "page_story_adds_unique", "page_story_adds_unique", "page_story_adds_unique", "page_story_adds", "page_story_adds", "page_story_adds", "page_story_adds_by_story_type_unique", "page_story_adds_by_story_type_unique", "page_story_adds_by_story_type_unique", "page_story_adds_by_story_type", "page_story_adds_by_story_type", "page_story_adds_by_story_type", "page_impressions_by_age_gender_unique", "page_impressions_by_age_gender_unique", "page_impressions_by_age_gender_unique", "page_impressions_by_country_unique", "page_impressions_by_country_unique", "page_impressions_by_country_unique", "page_impressions_by_locale_unique", "page_impressions_by_locale_unique", "page_impressions_by_locale_unique", "page_impressions_by_city_unique", "page_impressions_by_city_unique", "page_impressions_by_city_unique", "page_story_adds_by_age_gender_unique", "page_story_adds_by_age_gender_unique", "page_story_adds_by_age_gender_unique", "page_story_adds_by_country_unique", "page_story_adds_by_country_unique", "page_story_adds_by_country_unique", "page_story_adds_by_locale_unique", "page_story_adds_by_locale_unique", "page_story_adds_by_locale_unique", "page_impressions_unique", "page_impressions_unique", "page_impressions_unique", "page_impressions", "page_impressions", "page_impressions", "page_impressions_paid_unique", "page_impressions_paid_unique", "page_impressions_paid_unique", "page_impressions_paid", "page_impressions_paid", "page_impressions_paid", "page_impressions_organic_unique", "page_impressions_organic_unique", "page_impressions_organic_unique", "page_impressions_organic", "page_impressions_organic", "page_impressions_organic", "page_impressions_viral_unique", "page_impressions_viral_unique", "page_impressions_viral_unique", "page_impressions_viral", "page_impressions_viral", "page_impressions_viral", "page_impressions_by_story_type_unique", "page_impressions_by_story_type_unique", "page_impressions_by_story_type_unique", "page_impressions_by_story_type", "page_impressions_by_story_type", "page_impressions_by_story_type", "page_places_checkin_total", "page_places_checkin_total", "page_places_checkin_total", "page_places_checkin_total_unique", "page_places_checkin_total_unique", "page_places_checkin_total_unique", "page_places_checkin_mobile", "page_places_checkin_mobile", "page_places_checkin_mobile", "page_places_checkin_mobile_unique", "page_places_checkin_mobile_unique", "page_places_checkin_mobile_unique", "page_places_checkins_by_age_gender", "page_places_checkins_by_country", "page_places_checkins_by_city", "page_places_checkins_by_locale", "page_posts_impressions_unique", "page_posts_impressions_unique", "page_posts_impressions_unique", "page_posts_impressions", "page_posts_impressions", "page_posts_impressions", "page_posts_impressions_paid_unique", "page_posts_impressions_paid_unique", "page_posts_impressions_paid_unique", "page_posts_impressions_paid", "page_posts_impressions_paid", "page_posts_impressions_paid", "page_posts_impressions_organic_unique", "page_posts_impressions_organic_unique", "page_posts_impressions_organic_unique", "page_posts_impressions_organic", "page_posts_impressions_organic", "page_posts_impressions_organic", "page_posts_impressions_viral_unique", "page_posts_impressions_viral_unique", "page_posts_impressions_viral_unique", "page_posts_impressions_viral", "page_posts_impressions_viral", "page_posts_impressions_viral", "page_consumptions_unique", "page_consumptions_unique", "page_consumptions_unique", "page_consumptions", "page_consumptions", "page_consumptions", "page_consumptions_by_consumption_type_unique", "page_consumptions_by_consumption_type_unique", "page_consumptions_by_consumption_type_unique", "page_consumptions_by_consumption_type", "page_consumptions_by_consumption_type", "page_consumptions_by_consumption_type", "page_fans_by_like_source_unique", "page_fans_by_like_source", "page_fans", "page_fans_locale", "page_fans_city", "page_fans_country", "page_fans_gender", "page_fans_age", "page_fans_gender_age", "page_friends_of_fans", "page_active_users", "page_active_users", "page_active_users", "page_active_users_locale", "page_active_users_city", "page_active_users_country", "page_active_users_gender", "page_active_users_age", "page_active_users_gender_age", "page_storytellers", "page_storytellers", "page_storytellers", "page_storytellers_by_story_type", "page_storytellers_by_story_type", "page_storytellers_by_story_type", "page_storytellers_by_age_gender", "page_storytellers_by_age_gender", "page_storytellers_by_age_gender", "page_storytellers_by_country", "page_storytellers_by_country", "page_storytellers_by_country", "page_storytellers_by_locale", "page_storytellers_by_locale", "page_storytellers_by_locale", "page_engaged_users", "page_engaged_users", "page_engaged_users", "page_impressions_frequency_distribution", "page_impressions_frequency_distribution", "page_impressions_frequency_distribution", "page_impressions_viral_frequency_distribution", "page_impressions_viral_frequency_distribution", "page_impressions_viral_frequency_distribution", "page_posts_impressions_frequency_distribution", "page_posts_impressions_frequency_distribution", "page_posts_impressions_frequency_distribution", "page_views_unique", "page_views_unique", "page_stories", "page_stories", "page_stories", "page_stories_by_story_type", "page_stories_by_story_type", "page_stories_by_story_type"]

    names.each do |name|
      Facebook.find_or_create_by(:conditions => {:app_id => config['app_id'], :name => name}).destroy
    end

    names.each do |name|
      first = true
      since_date = Date.new(2011, 1, 1)
      until_date = Date.new(2011, 3, 1)

      loop do

        if !first
          since_date += 2.months
          until_date += 2.months
        end
        first = false

        insights = client.get_connections(config["app_id"], "insights/#{name}", {"since" => since_date.to_time.to_i, "until" => until_date.to_time.to_i}, {"access_token" => client.access_token})
        fb = Facebook.find_or_create_by(:app_id => config['app_id'], :name => name)

        if (!insights.nil? && !insights.first.nil?)
          insights.first.each do |key, value|
            next if key != "values"
            value.each do |item|
              fb.push(:values, item)
            end
          end
        end
        break if since_date > DateTime.now || until_date > DateTime.now
      end
    end
  end

end