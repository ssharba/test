require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to have_many(:addresses) }

  it { is_expected.to validate_presence_of(:f_name) }
  it { is_expected.to validate_presence_of(:l_name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_length_of(:phone).is_at_most(25) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(50) }
  it { is_expected.to allow_value("valid@email.com").for(:email) }
  it { is_expected.not_to allow_value("invalid@email").for(:email) }
  it { is_expected.not_to allow_value("invalidemail.com").for(:email) }
  it { is_expected.not_to allow_value("invalid@emailcom").for(:email) }

  it { is_expected.to accept_nested_attributes_for(:addresses) }

  describe "#update" do
    before { @person = create(:person) }

    it "will update successfully with the right attributes" do
      @person.update(f_name: "New firstname", l_name: "Last name")

      expect(@person.reload.f_name).to eql "New firstname"
      expect(@person.reload.l_name).to eql "Last name"
    end

    it "will not update with the wrong attributes" do
      @person.update(email: "wrong email.com")

      expect(@person.reload.email).to_not eql "wrong email.com"
    end
  end
end
