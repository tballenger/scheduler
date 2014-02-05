json.array!(@time_slots) do |time_slot|
  json.extract! time_slot, :id, :starts_at, :ends_at, :event_id, :contact_id
  json.url time_slot_url(time_slot, format: :json)
end
