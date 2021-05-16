# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  context 'create' do
    it 'fail without email and password' do
      expect { AdminUser.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'fail without email' do
      expect { AdminUser.create!(email: Faker::Internet.email) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'fail without password' do
      expect { AdminUser.create!(password: Faker::Internet.password) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'success with email and password' do
      AdminUser.create!(email: Faker::Internet.email, password: Faker::Internet.password)
      expect(AdminUser.count).to eq 1
    end
  end
end
