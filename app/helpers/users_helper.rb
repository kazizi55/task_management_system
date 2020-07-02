module UsersHelper
  def secure_pass(password)
    return if password == nil
    
    secure_password = password.crypt(Rails.application.credentials.salt[:salt_key])
    return secure_password
  end
end
