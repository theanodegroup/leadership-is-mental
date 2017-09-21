class LeadershipArticlesController < ApplicationController
  before_action :set_leadership_article, only: [:show, :edit, :update, :destroy]

  # GET /leadership_articles
  # GET /leadership_articles.json
  def index
    @leadership_articles = LeadershipArticle.all
  end

  # GET /leadership_articles/1
  # GET /leadership_articles/1.json
  def show
  end

  # GET /leadership_articles/new
  def new
    @leadership_article = LeadershipArticle.new
  end

  # GET /leadership_articles/1/edit
  def edit
  end

  # POST /leadership_articles
  # POST /leadership_articles.json
  def create
    @leadership_article = LeadershipArticle.new(leadership_article_params)

    respond_to do |format|
      if @leadership_article.save
        format.html { redirect_to @leadership_article, notice: 'Leadership article was successfully created.' }
        format.json { render :show, status: :created, location: @leadership_article }
      else
        format.html { render :new }
        format.json { render json: @leadership_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leadership_articles/1
  # PATCH/PUT /leadership_articles/1.json
  def update
    respond_to do |format|
      if @leadership_article.update(leadership_article_params)
        format.html { redirect_to @leadership_article, notice: 'Leadership article was successfully updated.' }
        format.json { render :show, status: :ok, location: @leadership_article }
      else
        format.html { render :edit }
        format.json { render json: @leadership_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leadership_articles/1
  # DELETE /leadership_articles/1.json
  def destroy
    @leadership_article.destroy
    respond_to do |format|
      format.html { redirect_to leadership_articles_url, notice: 'Leadership article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leadership_article
      @leadership_article = LeadershipArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leadership_article_params
      params.require(:leadership_article).permit(:title, :content, :pub_date, :summary, :source, :guid)
    end
end
