json.array!(@events) do |event|
  json.extract! event, :id, :name, :service_id, :day, :from, :to, :user_id
  json.url event_url(event, format: :json)
end
