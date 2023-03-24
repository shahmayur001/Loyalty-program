# frozen_string_literal: true

RSpec.describe UpdateLoyaltyPointsJob, type: :job do
  describe '#calculating loyalty points based on region' do
    context 'loyalty points in Default country' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 1000) }

      it 'in Default country for every $100 the end user spends they receive 10 points' do
        user.reload
        expect(user.loyalty_points).to eq 100
      end
    end

    context 'loyalty points in other countries' do
      let!(:user) { create(:user, :other_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 1000) }

      it 'in other countries for every $100 the end user spends they receive 20 points' do
        user.reload
        expect(user.loyalty_points).to eq 200
      end
    end
  end
end
