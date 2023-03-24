# frozen_string_literal: true

RSpec.describe MovieRewardsJob, type: :job do
  describe '#providing Movie reward for new user made their first transaction greater than 1000' do
    context 'movie rewards' do
      let!(:user) { create(:user, :default_country) }
      let(:transaction) { create(:transaction, user_id: user.id) }

      it 'should not provide Movie reward for the user first transaction is not > 1000' do
        transaction.update(amount: 1000)
        user.update(created_at: Date.today - 3.months)
        MovieRewardsJob.perform_now
        expect(user.rewards.first).to be nil
      end

      it 'should not provide Movie reward for the user first transaction is not > 1000' do
        transaction.update(amount: 900)
        user.update(created_at: Date.today - 3.months)
        MovieRewardsJob.perform_now
        expect(user.rewards.first).to be nil
      end

      it 'should provide Movie reward for the user first transaction is > 1000' do
        transaction.update(amount: 1000)
        user.update(created_at: Date.today - 60.days)
        MovieRewardsJob.perform_now
        expect(user.rewards.first.name).to eq 'Free Movie ticket'
      end
    end
  end
end
