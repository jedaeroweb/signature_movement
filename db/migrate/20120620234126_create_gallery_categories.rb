class CreateGalleryCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :gallery_categories do |t|
      t.string :title,:null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps null: false
    end
  end
end
