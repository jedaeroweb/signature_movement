class CreateReportCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :report_categories do |t|
      t.string :title, :limit=>60, :null=>false
      t.integer :reports_count, :default=>0, :null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps null: false
    end
  end
end
