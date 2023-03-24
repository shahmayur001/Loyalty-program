# frozen_string_literal: true

RSpec.describe CoffeeRewardsJob, type: :job do
  describe '#providing coffee reward for customers having greater than 100 loyalty points or on their birthday month' do
    context 'coffee rewards' do
      let!(:user) { create(:user, :default_country) }

      it 'should not provide Coffee reward for the customers having < 90 loyalty points and not birthday month' do
        user.update(loyalty_points: 90, date_of_birth: Date.today - 2.months)
        CoffeeRewardsJob.perform_now
        expect(user.rewards.first).to be nil
      end

      it 'should provide Coffee reward for the customers having birthday month' do
        user.update(date_of_birth: Date.today)
        create(:user_point, user_id: user.id, point_earned: 0)
        CoffeeRewardsJob.perform_now
        expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
      end

      it 'should provide Coffee reward for the customers having > 100 loyalty points' do
        user.update(date_of_birth: Date.today - 2.months)
        create(:user_point, user_id: user.id, point_earned: 100)
        CoffeeRewardsJob.perform_now
        expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
      end

      it 'should provide Coffee reward for the customers having > 100 loyalty points or birthday month' do
        user.update(date_of_birth: Date.today)
        create(:user_point, user_id: user.id, point_earned: 110)
        CoffeeRewardsJob.perform_now
        expect(user.rewards.first.name).to eq 'Free Coffee_Reward'
      end
    end
  end
end
