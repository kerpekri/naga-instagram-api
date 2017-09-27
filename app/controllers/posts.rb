NagaInstagramApi::App.controllers :posts do
  
  get :index, :params => [:from, :to, :hash_tag] do
    if request.xhr?
      from_date = Date.parse params[:from]
      to_date = Date.parse params[:to]

      instagram_api_data = InstagramApi.tag(params[:hash_tag]).recent_media.data
      filtered_data = []

      JSON.parse(instagram_api_data.to_json).each do |data|
        post_date = Date.parse Time.at(data['created_time'].to_i).strftime("%d-%m-%Y")
        next if !(from_date..to_date).cover?(post_date)

        filtered_data << {
          data['id'] => {
            :instagram_post_id => data['id'],
            :username => data['user']['username'],
            :like_count => data['likes']['count'],
            :comment_count => data['comments']['count'],
            :link_to_post => data['link'],
            :creation_time => Time.at(data['created_time'].to_i).strftime("%d-%m-%Y"),
            :post_type => data['type'],
            :thumbnail => data['images']['thumbnail']['url']
          }
        }

      end

      render :load_posts_tbody, :layout => false, :locals => {:filtered_data => filtered_data}
    else
      "<h1>Not an Ajax request!</h1>"
    end
  end

  get :create, :params => [:instagram_post_info] do
    if request.xhr?
      data = params[:instagram_post_info]

      post = Post.new do |p|
        p.instagram_post_id = data['instagramPostId']
        p.username = data['username']
        p.like_count = data['likeCount']
        p.comment_count = data['commentCount']
        p.link_to_post = data['linkToPost']
        #p.creation_date = data['creationTime'] #TODO
        p.post_type = data['postType']
        p.save!
      end

      render :load_link_to_graph, :layout => false, :locals => {:post_id => post.id}
    else
      "<h1>Not an Ajax request!</h1>"
    end
  end

  get :show, :with => :id do
    @post = Post.find_by(id: params[:id])
    render :test_file
  end
end
