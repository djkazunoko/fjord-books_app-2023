# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  scenario 'user creates a new report' do
    user = FactoryBot.create(:user)

    visit root_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect(page).to have_content 'ログインしました。'

    expect {
      click_link '日報'
      click_link '日報の新規作成'
      fill_in 'タイトル', with: 'テスト日報'
      fill_in '内容', with: '日報を作成'
      click_button '登録する'

      expect(page).to have_content '日報が作成されました。'
      expect(page).to have_content 'テスト日報'
      expect(page).to have_content "作成者: #{user.email}"
    }.to change(user.reports, :count).by(1)
  end
end
