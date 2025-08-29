class CreateAuthenticationProviders < ActiveRecord::Migration[6.0]
    def change
        create_table "authentication_providers", :force => true do |t|
            t.string :name,:limit=>60,:null=>false
            t.timestamps null: false
        end
        add_index "authentication_providers", ["name"], :name => "index_name_on_authentication_providers"
    end
  end
