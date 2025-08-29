class CreateFaqs < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.references :faq_category, null: false
      t.string :title, null: false
      t.integer :order_no, null: false, default: 0
      t.integer :count, default: 0, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
