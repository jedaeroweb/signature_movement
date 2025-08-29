class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.references :user,:null=>false
      t.string :title, :limit=>60, :null=>false
      t.integer :default_view_count, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.integer :count, :null=>false, :default=>0
      t.timestamps null: false
    end
  end
end
