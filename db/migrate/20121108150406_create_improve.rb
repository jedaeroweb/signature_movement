class CreateImprove < ActiveRecord::Migration[6.0]
  def change
    create_table :improve do |t|
      t.string :title, limit: 60, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
