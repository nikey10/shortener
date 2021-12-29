require "rails_helper"

RSpec.describe Website, type: :model do

  let(:website) { Website.new(url: 'https://example.com') }

  it 'is valid' do
    expect(website).to be_valid
  end

  it 'should be of class Item' do
    expect(subject.class).to eq Website
  end

  describe 'Database table' do
    it { should have_db_column :id }
    it { should have_db_column :url }
    it { should have_db_column :title }
    it { should have_db_column :visits }
    it { should have_db_column :created_at }
    it { should have_db_column :updated_at }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { should validate_numericality_of(:visits).only_integer }
    it 'Not valid url format' do
      expect(Website.new(url: 'example.com').valid?).to eq(false)
    end

  end

  describe 'Shorteners' do
    it 'create correct shot version for record' do
      website = Website.create(url: 'https://example.com', id: 1)
      expect(website.short).to eq('b')
    end

    it 'return correct website for slug' do
      website = Website.create(url: 'https://example.com', id: 1)
      expect(Website.find_short('b')).to eq website
    end

    it 'return nil for not existing website' do
      expect(Website.find_short('bd')).to eq nil
    end
  end
end