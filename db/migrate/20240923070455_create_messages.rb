class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :room, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
