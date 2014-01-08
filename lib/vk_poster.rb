module VK
  class Config
    attr_accessor :app_id, :app_secret, :secret_token
  end

  class ImagePoster
    require 'vkontakte_api'
    # attr_reader :post_msg
    attr_accessor :app_id, :app_secret, :secret_token

    def initialize
      @config = self.class.configuration
      VkontakteApi.configure do |config|
        config.app_id       = @config.app_id
        config.app_secret   = @config.app_secret
        config.adapter = :net_http
        config.http_verb = :post
        config.faraday_options = {
          ssl: {
            :verify => false
          },
        }
      end
      @app = VkontakteApi::Client.new(@config.secret_token)
    end
    class << self
      attr_reader :configuration
    end

    def self.configure
      @configuration ||= Config.new
      yield @configuration
    end

    def wall_post(gid, file, caption=nil)
      us = @app.photos.get_wall_upload_server(gid: gid)
      up = VkontakteApi.upload(url: us.upload_url, file1: ["#{file}", 'image/jpeg'])
      up.caption = "#{caption}"
      up.gid = gid
      save = @app.photos.save_wall_photo(up)
      @post_msg = @app.wall.post(attachments: save.first.id, owner_id: "-#{gid}", from_group: 1 )
    end

    def wall_repost(wall_post_id, gid)
      @app.wall.repost(object: wall_post_id, group_id: gid )
    end

  end
end

