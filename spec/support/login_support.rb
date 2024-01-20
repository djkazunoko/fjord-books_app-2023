# frozen_string_literal: true

module LoginSupport
  def sign_in_as(user)
    visit root_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
