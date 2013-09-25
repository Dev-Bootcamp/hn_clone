########### GET ############
get '/' do
  @posts = Post.all
  erb :index
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/user/:id/posts' do
  @posts = User.find(params[:id]).posts
  erb :index
end

get '/user/:id/comments' do
  @comments = User.find(params[:id]).comments
  erb :comments
end

get '/submit' do
  erb :submit
end

get '/post/:id' do
  @comments = Post.find(params[:id]).comments
  @post = Post.find(params[:id])
  erb :post_page
end

########### POST ###########

post '/post/create' do

  post = Post.create(title: params[:title], url: params[:url], user_id: session[:id])
  redirect to ("/post/#{post.id}")
end

post '/comment/:post_id/:user_id' do
  # create a comment for a specific post
end
