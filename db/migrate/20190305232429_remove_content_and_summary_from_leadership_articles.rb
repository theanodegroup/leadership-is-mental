class RemoveContentAndSummaryFromLeadershipArticles < ActiveRecord::Migration
  def change
    remove_column :leadership_articles, :summary, :text
    remove_column :leadership_articles, :content, :text
  end
end
