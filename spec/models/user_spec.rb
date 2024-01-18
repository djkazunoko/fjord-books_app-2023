# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe '#name_or_email' do
    it 'returns name when name is present' do
      user = FactoryBot.build(:user, name: 'alice')

      expect(user.name_or_email).to eq 'alice'
    end

    it 'returns email when name is not present' do
      user = FactoryBot.build(:user)

      expect(user.name_or_email).to eq 'tester@example.com'
    end
  end
end
