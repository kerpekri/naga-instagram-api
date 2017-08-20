require 'sinatra'
require 'haml'
require 'date'
require 'instagram_api'
require 'json'
require 'pry'

InstagramApi.config do |config|
  config.access_token = '3466732372.c2fab6f.2b9c0d50e67e4fa5875cc71903f74304'
end

get '/' do
	haml :index
end

get '/load_data' do
  if request.xhr?
    from_date = Date.parse @params[:from]
    to_date = Date.parse @params[:to]

    instagram_api_data = InstagramApi.tag(@params[:hash_tag]).recent_media.data
    filtered_data = []

    JSON.parse(instagram_api_data.to_json).each do |data|
      post_date = Date.parse Time.at(data['created_time'].to_i).strftime("%d-%m-%Y")
      next if !(from_date..to_date).cover?(post_date)

      filtered_data << {
        data['id'] => {
          :username => data['user']['username'],
          :like_count => data['likes']['count'],
          :comment_count => data['comments']['count'],
          :link_to_post => data['link'],
          :creation_time => Time.at(data['created_time'].to_i).strftime("%d-%m-%Y"),
          :post_type => data['type']
        }
      }

    end

    haml :instagram_tbody, :layout => false, :locals => {:filtered_data => filtered_data}
  else
    "<h1>Not an Ajax request!</h1>"
  end
end

#https://github.com/sinatra/sinatra-book/blob/master/book/Models.markdown