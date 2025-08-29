class Operator < ApplicationRecord
    self.table_name = 'admins'
    attr_accessor :password, :password_confirmation
    validates_uniqueness_of :email
    validates_length_of :email, within: 4..40
    validates_length_of :name, within: 1..60
    validates_length_of :password, :within => 5..255

    has_one :admin_picture, dependent: :destroy
    has_many :roles_admin, foreign_key: :admin_id
    has_many :role, through: :roles_admin

    accepts_nested_attributes_for :roles_admin
    accepts_nested_attributes_for :admin_picture, :allow_destroy => true

    def password=(pass)
        if pass.present?
            @password = pass
            admin = Admin.new(login_id: login_id, password: pass)
            self.encrypted_password = admin.encrypted_password
        end
    end
end
