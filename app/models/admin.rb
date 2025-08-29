class Admin < ApplicationRecord
    self.table_name = 'users'
    devise :database_authenticatable, :registerable, :validatable, :timeoutable
    validates_length_of :login_id, within: 4..40
    default_scope {where(:admin => true)}
    has_one :admin_picture, dependent: :destroy

    def timeout_in
        1.day
    end
end
