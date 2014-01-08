require './lib/vk_poster'

# Configure Poster
VK::ImagePoster.configure do |config|
  config.app_id = APP_ID
  config.app_secret = APP_SECRET
  config.secret_token  = APP_SECRET_TOKEN
end

poster = VK::ImagePoster.new

# Change group or public
gid = '31644851'

# Upload image on group wall
poster.wall_post(gid , "test2.jpg")
