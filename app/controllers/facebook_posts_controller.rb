class FacebookPostsController < ApplicationController
  before_action :set_facebook_post, only: [:show, :edit, :update, :destroy]

  # GET /facebook_posts
  # GET /facebook_posts.json
  def index
    @facebook_posts = FacebookPost.all
  end

  # GET /facebook_posts/1
  # GET /facebook_posts/1.json
  def show
  end

  # GET /facebook_posts/new
  def new
    @facebook_post = FacebookPost.new
  end

  # GET /facebook_posts/1/edit
  def edit
  end

  # POST /facebook_posts
  # POST /facebook_posts.json
  def create
    @facebook_post = FacebookPost.new(facebook_post_params)

    respond_to do |format|
      if @facebook_post.save
        format.html { redirect_to @facebook_post, notice: 'Facebook post was successfully created.' }
        format.json { render :show, status: :created, location: @facebook_post }
      else
        format.html { render :new }
        format.json { render json: @facebook_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facebook_posts/1
  # PATCH/PUT /facebook_posts/1.json
  def update
    respond_to do |format|
      if @facebook_post.update(facebook_post_params)
        format.html { redirect_to @facebook_post, notice: 'Facebook post was successfully updated.' }
        format.json { render :show, status: :ok, location: @facebook_post }
      else
        format.html { render :edit }
        format.json { render json: @facebook_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook_posts/1
  # DELETE /facebook_posts/1.json
  def destroy
    @facebook_post.destroy
    respond_to do |format|
      format.html { redirect_to facebook_posts_url, notice: 'Facebook post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facebook_post
      @facebook_post = FacebookPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facebook_post_params
      params.require(:facebook_post).permit(:title, :facebook_url, :guid, :image_url)
    end
end
