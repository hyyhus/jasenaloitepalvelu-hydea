json.extract! user, :id, :admin, :moderator, :persistent_id, :name, :email, :title, :created_at, :updated_at
json.url user_url(user, format: :json)