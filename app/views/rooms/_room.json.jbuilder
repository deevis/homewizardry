json.extract! room, :id, :name, :door_contact_id, :speaker_id, :created_at, :updated_at
json.url room_url(room, format: :json)
