# frozen_string_literal: true

RSpec.describe CashRebatesJob, type: :job do
  describe '#providing 5% Cash Rebates for customers made atleast 10 transaction greater that $100' do
    context 'cash rebates' do
      let!(:user) { create(:user, :default_country) }

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions' do
        create_list(:transaction, 5, user_id: user.id)
        CashRebatesJob.perform_now
        expect(user.rewards.first).to be nil
      end

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions < 100 dollars' do
        create_list(:transaction, 9, user_id: user.id)
        CashRebatesJob.perform_now
        expect(user.rewards.first).to be nil
      end

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions > 100 dollars' do
        create_list(:transaction, 10, user_id: user.id)
        CashRebatesJob.perform_now
        expect(user.rewards.first.name).to eq '5% Cash Rebate'
      end
    end
  end
end
