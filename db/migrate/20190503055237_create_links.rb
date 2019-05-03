class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links, id: :uuid do |t|
      t.text :url
      t.text :slug
      t.references :user, foreign_key: true, type: :uuid, null: true

      t.timestamps
    end
  end
end
