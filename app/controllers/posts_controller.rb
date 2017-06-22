class PostsController < ApplicationController
  # #12 use a before_action filter to call the require_sign_in method before each of our controller actions, except for the show action
  before_action :require_sign_in, except: :show
  # #10 use a second before_action filter to check the role of a signed-in user. If the current_user isn't authorized based on their role, we'll redirect them to the posts show view
  before_action :authorize_user, except: [:show, :new, :create]

  before_action :authorize_moderator, only: [:destroy]

  def show
    # #19 find the post that corresponds to the id in the params that was passed to "show" and assign it to @post. Unlike in the "index' method, in the "show" method, we populate an instance variable with a single post, rather than a collection of posts
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    # #7 create an instance variable, @post, then assign it an empty post returned by Post.new
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    # #14 assign @post.user the same way as @post.topic was assigned above to properly scope the new post
    @post.user = current_user
    # #10 if we successfully save Post to the database, we display a success message using flash[:notice] and redirect the user to the route generated by @post. Redirecting to @post will direct the user to the posts show view
    if @post.save
      # #11 assign a value to flash[:notice]. The "flash" hash provides a way to pass temporary values between actions. Any value placed in "flash" will be available in the next action and then deleted
      flash[:notice] = "Post was saved."
      # #36 change the redirect to use the nested post path
      redirect_to [@topic, @post]
    else
      # #12 if we do not successfully save Post to the database, we display an error message and render the new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      # #37 change the redirect to use the nested post path
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving your post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # #8 call destroy on @post. If that call successful, we set a flash message and redirect the user to the posts index view. If destroy fails then we redirect user to the show view using render :show
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      # #38 when a post is deleted, we direct users to the topic show view
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_moderator
    return unless current_user.moderator?

    post = Post.find(params[:id])
      flash[:alert] = "This is not allowed for moderators."
      redirect_to [post.topic, post]
  end

  def authorize_user
    return unless current_user.member?

    post = Post.find(params[:id])
    unless current_user == post.user
      flash[:alert] = "This is not allowed for members."
      redirect_to [post.topic, post]
    end
  end
end
