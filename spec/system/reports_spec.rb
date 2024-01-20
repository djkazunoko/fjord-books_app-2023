# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  include LoginSupport

  let(:user) { FactoryBot.create(:user) }
  let!(:report) { FactoryBot.create(:report, user: user) }

  scenario 'user creates a new report' do
    sign_in_as user

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

  scenario 'user edits a report' do
    sign_in_as user

    click_link '日報'

    click_link 'この日報を表示'

    click_link 'この日報を編集'
    fill_in 'タイトル', with: '日報1'
    fill_in '内容', with: '書き換えました。'
    click_button '更新する'

    expect(page).to have_content '日報が更新されました。'
    expect(page).to have_content 'タイトル: 日報1'
    expect(page).to have_content '内容: 書き換えました。'
  end

  scenario 'user deletes a report' do
    sign_in_as user

    click_link '日報'

    click_link 'この日報を表示'

    expect {
      click_button 'この日報を削除'
      expect(page).to have_content '日報が削除されました。'
    }.to change(user.reports, :count).by(-1)
  end
end
