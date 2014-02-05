json.array!(@services) do |service|
  json.extract! service, :id, :name, :description, :price, :minutes_duration
  json.url service_url(service, format: :json)
end
