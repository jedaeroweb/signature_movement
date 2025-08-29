class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.string :title, :limit=>60, :null=>false
      t.integer :compliments_count, :default=>0, :null=>false
      t.string :photo
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end
  end
end
