class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.belongs_to :comment, index: true
      t.text :text

      t.timestamps null: false
    end
  end
end
