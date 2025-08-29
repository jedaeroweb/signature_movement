class CreateCompliments < ActiveRecord::Migration[6.0]
  def change
    create_table :compliments do |t|
      t.references :bank, :null=>false
      t.references :compliment_category, :null=>false
      t.references :user, :null=>false
      t.string :title,:limit=>60, :null=>false
      t.integer :default_view_count, :null=>false, :default=>0
      t.integer :compliment_comment_count, :null=>false ,:default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end
  end
end
