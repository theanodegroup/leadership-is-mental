class RemoveImageUrlFromLeadershipArticles < ActiveRecord::Migration
  def change
    remove_column :leadership_articles, :image_url, :text
  end
end
