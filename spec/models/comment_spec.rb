# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'create' do
    it 'failed without post' do
      expect { Comment.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context 'with post' do
      before(:each) do
        admin_user = AdminUser.create!(email: Faker::Internet.email, password: Faker::Internet.password)
        category = Category.create!
        @post = Post.create!(admin_user: admin_user, category: category)
      end

      it 'failed without name and body' do
        expect { create_comment_with_post! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'failed with invalid name' do
        [nil, '', Faker::Lorem.characters(number: 1), Faker::Lorem.characters(number: 21)].each do |name|
          expect { create_comment_with_post!(name: name, body: Faker::Lorem.word) }
            .to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      it 'failed with invalid body' do
        expect { create_comment_with_post!(name: valid_name, body: nil) }.to raise_error(ActiveRecord::RecordInvalid)
        expect { create_comment_with_post!(name: valid_name, body: '') }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'successful with valid name length and body' do
        comment = create_comment_with_post!(name: Faker::Lorem.characters(number: 10), body: Faker::Lorem.word)
        expect(Comment.count).to eq 1
        expect(comment.post).to eq @post
      end
    end
  end

  private

  def create_comment_with_post!(**kwargs)
    Comment.create!({ post: @post }.merge(kwargs))
  end

  def valid_name
    Faker::Lorem.characters(number: 10)
  end
end
