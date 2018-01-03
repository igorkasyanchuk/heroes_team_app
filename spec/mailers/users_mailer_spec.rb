require 'rails_helper'

RSpec.describe UsersMailer, type: :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = FactoryBot.create(:user, :sale)
    UsersMailer.credentials(@user).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  describe 'credentials' do
    it 'should send an email' do
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'renders the receiver email' do
      ActionMailer::Base.deliveries.first.to.should == [@user.email]
    end

    it 'should set the subject to the correct subject' do
      ActionMailer::Base.deliveries.first.subject.should == 'Your credentials'
    end

    it 'renders the sender email' do
      ActionMailer::Base.deliveries.first.from.should == ['salesassistant@mail.com']
    end
  end
  describe 'credentials views' do
    let(:mail) { UsersMailer.credentials(@user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your credentials')
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(['salesassistant@mail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hello')
    end
  end
end
