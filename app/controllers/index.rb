########### GET ############
get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  @posts = Post.all
  erb :index
end

get '/user/:id' do
  @user = User.find(params[:id])
  if @user.valid?
    session[:user_id] = @user.id
    erb :profile
  else
    redirect to ('/')
  end
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

get '/logout' do 
  session.clear
  redirect to '/'
end

get '/login' do
  erb :login
end

get '/new_user' do
  erb :create_user
end

########### POST ###########

post '/post/create' do
  post = Post.create(title: params[:title], url: params[:url], user_id: session[:user_id])
  redirect to ("/post/#{post.id}")
end

post '/comment/:post_id/:user_id' do
  # create a comment for a specific post
end

post '/login' do
  user = User.authenticate(params[:username], params[:password])
  if user.valid?
    session[:user_id] = user.id
  end
  redirect '/'
end

post '/create_user' do
  user = User.create(username: params[:username], password: params[:password])
  session[:user_id] = user.id
  redirect to ('/')
end

post '/create_comment/:post_id' do
  comment = Comment.create(body: params[:body], user_id: session[:user_id], post_id: params[:post_id])
  redirect to ("/post/#{params[:post_id]}")
end
