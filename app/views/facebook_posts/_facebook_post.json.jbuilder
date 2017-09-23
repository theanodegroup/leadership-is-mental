json.extract! facebook_post, :id, :title, :facebook_url, :guid, :image_url, :created_at, :updated_at
json.url facebook_post_url(facebook_post, format: :json)