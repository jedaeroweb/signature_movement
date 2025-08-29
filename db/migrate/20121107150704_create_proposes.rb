class CreateProposes < ActiveRecord::Migration[6.0]
  def change
    create_table :proposes do |t|
      t.references :user, null: false
      t.string :title, limit: 60, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
