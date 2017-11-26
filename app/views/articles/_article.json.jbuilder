json.extract! article, :id, :title_phrase_id, :summary_phrase_id, :source_phrase_id, :image_url_phrase_id, :created_at, :updated_at
json.url article_url(article, format: :json)