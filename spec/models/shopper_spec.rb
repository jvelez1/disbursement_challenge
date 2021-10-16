require 'rails_helper'

RSpec.describe Shopper, type: :model do
  describe '#validations' do
    subject { build(:shopper) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:nif) }
    it { is_expected.to validate_uniqueness_of(:nif).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.not_to allow_value('testemail').for(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('').for(:email) }
  end

  describe '#associations' do
    it { is_expected.to have_many(:orders).dependent(:nullify) }
  end
end
