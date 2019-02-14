class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :messages, null: false, default: ""
      t.timestamps
    end
  end
end
