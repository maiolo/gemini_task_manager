# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:pending, :in_progress, :completed]) }
  end
end
