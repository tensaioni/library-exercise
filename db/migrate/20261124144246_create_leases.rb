class CreateLeases < ActiveRecord::Migration[8.1]
  def change
    create_table :leases do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :reader, null: false, foreign_key: true
      t.datetime :returned_at, index: true
      t.timestamps
    end
  end
end
