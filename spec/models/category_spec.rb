# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'create successfully' do
    Category.create!
    expect(Category.count).to eq 1
  end
end
