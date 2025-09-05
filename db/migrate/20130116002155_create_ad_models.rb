class CreateAdModels < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_models do |t|
      t.references :user,:null=>false
      t.string :title, :null=>false, :limit=>60
      t.string :photo, :null=>false
      t.string :description, :null=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end
  end
end
