class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.timestamps
      t.integer :room_id
    end
  end
end
