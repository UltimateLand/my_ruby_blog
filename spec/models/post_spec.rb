# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'without admin user' do
    it 'cannot create' do
      expect { Post.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'with admin user' do
    before(:each) do
      @admin_user = AdminUser.create!(email: Faker::Internet.email, password: Faker::Internet.password)
    end

    it 'cannot create without category' do
      expect { create_post! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'create with category successfully' do
      post = create_post!(category: Category.create!)
      expect(Post.count).to eq 1
      expect(post.admin_user).to eq @admin_user
    end

    private

    def create_post!(**kwargs)
      Post.create!({ admin_user: @admin_user }.merge(kwargs))
    end
  end
end
