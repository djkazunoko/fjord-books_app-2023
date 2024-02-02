# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe '#name_or_email' do
    it 'returns name when name is present' do
      user.name = 'alice'

      expect(user.name_or_email).to eq 'alice'
    end

    it 'returns email when name is not present' do
      expect(user.name_or_email).to include '@example.com'
    end
  end
end
