json.extract! basket, :id, :name, :created_at, :updated_at
json.url basket_url(basket, format: :json)