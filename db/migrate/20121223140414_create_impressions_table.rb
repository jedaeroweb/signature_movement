class CreateImpressionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :impressions, :force => true do |t|
      t.string :impressionable_type, :limit=>100
      t.integer :impressionable_id
      t.integer :user_id
      t.string :controller_name, :limit=>100
      t.string :action_name, :limit=>100
      t.string :view_name, :limit=>100
      t.string :request_hash, :limit=>100
      t.string :ip_address, :limit=>100
      t.string :session_hash, :limit=>100
      t.text :message
      t.text :referrer
      t.string :params, :limit=>150
      t.timestamps null: false
    end

    add_index :impressions, [:impressionable_type, :impressionable_id, :params], :name => "poly_params_request_index", :unique => false
    add_index :impressions, [:impressionable_type, :impressionable_id, :request_hash], :name => "poly_request_index", :unique => false
    add_index :impressions, [:impressionable_type, :impressionable_id, :ip_address], :name => "poly_ip_index", :unique => false
    add_index :impressions, [:impressionable_type, :impressionable_id, :session_hash], :name => "poly_session_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:request_hash], :name => "controlleraction_request_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:ip_address], :name => "controlleraction_ip_index", :unique => false
    add_index :impressions, [:controller_name,:action_name,:session_hash], :name => "controlleraction_session_index", :unique => false
    add_index :impressions, :user_id
  end
end
