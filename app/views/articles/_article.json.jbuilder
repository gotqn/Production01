json.extract! article, :id, :name, :description, :content, :image, :created_by_user_id, :created_at, :updated_at
json.url article_url(article, format: :json)