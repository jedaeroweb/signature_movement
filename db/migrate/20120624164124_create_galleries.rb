class CreateGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :galleries do |t|
      t.references :gallery_category,:null=>false
      t.string :title,:null=>false
      t.string :photo,:null=>false
      t.text :content,:null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps null: false
    end
  end
end
