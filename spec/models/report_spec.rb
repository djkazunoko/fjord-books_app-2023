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

  describe '#created_on' do
    it 'returns the created date' do
      report = FactoryBot.build(:report)

      report.created_at = Time.zone.parse('2024/1/19')

      expect(report.created_on).to eq Date.new(2024, 1, 19)
    end
  end
end
