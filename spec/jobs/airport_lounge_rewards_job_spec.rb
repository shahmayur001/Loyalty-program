# frozen_string_literal: true

RSpec.describe AirportLoungeRewardsJob, type: :job do
  describe '#providing airport lounge reward for Gold tier customers' do
    context 'airport lounge reward' do
      let!(:user) {create(:user, :default_country)}

      it 'should not provide AirportLoungeRewards for Standard tier customers' do
        user.update(loyalty_tier: 'standard')
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end

      it 'should provide AirportLoungeRewards for Gold tier customers' do
        user.update(loyalty_tier: 'gold')
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first.name).to eq "Airport Lounge Access Reward"
      end

      it 'should not provide AirportLoungeRewards for the customers having 0 loyalty points' do
        user.update(loyalty_points: 0)
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end

      it 'should not provide AirportLoungeRewards for the customers having less than 1000 loyalty points' do
        user.update(loyalty_points: 100)
        create(:user_point, user_id: user.id, point_earned: 100)
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end
    end
  end
end
