require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to validate_presence_of(:f_name) }
  it { is_expected.to validate_presence_of(:l_name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:email) }

end
