# frozen_string_literal: true

RSpec.describe BonusPointsJob, type: :job do
  describe '#providing bonus points for customers made greater that $2000 in current quater' do
    context 'bonus points' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 100) }

      it 'should not provide Bonus points for the customers who did not made transaction > 2000 in current quater' do
        user.reload
        loyalty_points = user.loyalty_points
        BonusPointsJob.perform_now
        user.reload
        expect(user.loyalty_points).to eq (loyalty_points)
      end
    end

    context 'bonus points' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 100, created_at: Date.today - 4.months) }
      it 'should not provide Bonus points for the customers who transaction > 2000 but not in current quater' do
        user.reload
        loyalty_points = user.loyalty_points
        BonusPointsJob.perform_now
        user.reload
        expect(user.loyalty_points).to eq (loyalty_points)
      end
    end

    context 'bonus points' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 2000, created_at: Date.today) }
      it 'should provide Bonus points for the customers who made transaction > 2000 in current quater' do
        user.reload
        loyalty_points = user.loyalty_points
        BonusPointsJob.perform_now
        user.reload
        expect(user.loyalty_points).to eq (loyalty_points + 100)
      end
    end
  end
end
