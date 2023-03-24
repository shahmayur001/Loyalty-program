# frozen_string_literal: true

RSpec.describe ExpiringLoyaltyPointsJob, type: :job do
  describe '#expiring loyalty points at the end of every year' do
    context 'expiring loyalty points' do
      let!(:user) { create(:user, :default_country, loyalty_points: 1000) }

      it 'should not expire the loyalty points at current year' do
        ExpiringLoyaltyPointsJob.perform_now
        user.reload
        expect(user.loyalty_points).to eq 1000
      end

      it 'should expire previous year loyalty points' do
        user.update(created_at: Date.today - 1.year)
        ExpiringLoyaltyPointsJob.perform_now
        user.reload
        expect(user.loyalty_points).to eq 0
      end
    end
  end
end
