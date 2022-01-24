class CreatePlayedMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :played_messages do |t|
      t.string :message, limit: 1000
      t.string :message_type, limit: 40
      t.belongs_to :room, foreign_key: true

      t.timestamps
    end
  end
end
