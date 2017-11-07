require 'rails_helper'

  RSpec.describe Person, type: :model do
    it { should accept_nested_attributes_for(:addresses) }
  end
