# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:report)).to be_valid
  end

  describe '#editable?' do
    it 'is editable by the owner' do
      report = FactoryBot.build(:report)
      owner = report.user

      expect(report.editable?(owner)).to eq true
    end

    it 'is not editable by the other user' do
      report = FactoryBot.build(:report)
      other_user = FactoryBot.build(:user)

      expect(report.editable?(other_user)).to eq false
    end
  end
end
