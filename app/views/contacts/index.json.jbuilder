json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :first_name, :last_name, :email_address, :phone_number, :xero_uid, :user_id
  json.url contact_url(contact, format: :json)
end
