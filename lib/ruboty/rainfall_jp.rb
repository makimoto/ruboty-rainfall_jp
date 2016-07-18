require 'json'
require 'cgi'
require 'open-uri'

module Ruboty
  module Handlers
    class RainfallJp < Base
      YAHOO_JAPAN_APP_ID = ENV['YAHOO_JAPAN_APP_ID']
      DEFAULT_LOCATION = 'Ebisu'

      on(
        /Tell rainfall(?: (?:at|in) (?<query>.+))?/i,
        name: 'rainfall_jp',
        description: 'show rainfall forecast'
      )

      def rainfall_jp(message)
        if YAHOO_JAPAN_APP_ID.nil?
          raise "ENV['YAHOO_JAPAN_APP_ID'] is required for this command"
        end

        query = message.match_data['query'] || DEFAULT_LOCATION
        geometry = fetch_coodinated_geometry(query)

        if geometry.nil?
          message.reply('ಠ_ಠ')
          message.reply("Location '#{query}' is not found.")
          return
        end

        result = fetch_rainfall(geometry)
        message.reply("Rainfall forecast: #{query} (#{geometry})")
        message.reply(result)
      rescue Exception => e
        message.reply('ಠ_ಠ')
        message.reply(e)
        message.reply(e.backtrace)
      end

      private

      def fetch_coodinated_geometry(query)
        url = "http://geo.search.olp.yahooapis.jp/OpenLocalPlatform/V1/geoCoder?appid=#{YAHOO_JAPAN_APP_ID}&output=json&query=#{CGI.escape(query)}"
        response = JSON.parse(open(url).read)
        features = response["Feature"]
        if features.nil? || features.first.nil?
          return nil
        end
        features.first["Geometry"]["Coordinates"]
      end
      
      def fetch_rainfall(geometry)
        url = "http://weather.olp.yahooapis.jp/v1/place\?appid\=#{YAHOO_JAPAN_APP_ID}\&output=json&coordinates\=#{geometry}"
        response = JSON.parse(open(url).read)
        features = response["Feature"]
        if features.nil? || features.first.nil?
          return nil
        end
        datapoints = features.first["Property"]["WeatherList"]["Weather"]
        result = StringIO.new
        datapoints.each do |data|
          result.puts("#{Time.parse(data["Date"]).strftime("%m-%d %H:%M")} #{data["Rainfall"]} mm/h")
        end
        result.string
      end
    end
  end
end
