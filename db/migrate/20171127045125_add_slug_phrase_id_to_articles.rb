class AddSlugPhraseIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :slug_phrase_id, :integer
  end
end
