
class Admin < User
  default_scope { where(admin: true) }

  def self.model_name
    User.model_name
  end

  # admin임을 보장
  def admin?
    true
  end
end
