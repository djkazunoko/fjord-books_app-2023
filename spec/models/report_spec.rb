# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:owner) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:report) { FactoryBot.create(:report, user: owner) }
  let(:mentioning_report) { FactoryBot.create(:report, content: "http://localhost:3000/reports/#{report.id}") }

  it 'has a valid factory' do
    expect(report).to be_valid
  end

  describe '#editable?' do
    it 'is editable by the owner' do
      expect(report.editable?(owner)).to eq true
    end

    it 'is not editable by the other user' do
      expect(report.editable?(other_user)).to eq false
    end
  end

  describe '#created_on' do
    it 'returns the created date' do
      report.created_at = Time.zone.parse('2024/1/19')

      expect(report.created_on).to eq Date.new(2024, 1, 19)
    end
  end

  describe '#save_mentions' do
    context 'when the mentioning report is created' do
      it 'can mention other reports' do
        expect(report.mentioned_reports).to include mentioning_report
      end
    end

    context 'when the mentioning report is updated' do
      it 'updates mentions to other reports' do
        mentioning_report.content = 'no mention'
        mentioning_report.save

        expect(report.mentioned_reports).to_not include mentioning_report
      end

      it 'can not mention its own report' do
        report.content = "http://localhost:3000/reports/#{report.id}"
        report.save

        expect(report.mentioned_reports).to_not include report
      end
    end

    context 'when the mentioning report is deleted' do
      it 'deletes mentions to other reports' do
        mentioning_report.destroy

        expect(report.mentioned_reports).to be_empty
      end
    end
  end
end
