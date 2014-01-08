vk-poster
=========
Simple poster on publics and groups for vk.com

How to use

Configure Poster
<pre>
  VK::ImagePoster.configure do |config|
    config.app_id = APP_ID
    config.app_secret = APP_SECRET
    config.secret_token  = APP_SECRET_TOKEN
  end
</pre>
Create a poster
<pre>  poster = VK::ImagePoster.new</pre>
Change group or public
<pre>  gid = '31644851' </pre>
Upload image on group wall
<pre>  poster.wall_post(gid , "test2.jpg")</pre>
