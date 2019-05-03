class CreateClicks < ActiveRecord::Migration[5.2]
  def change
    create_table :clicks, id: :uuid do |t|
      t.references :link, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
