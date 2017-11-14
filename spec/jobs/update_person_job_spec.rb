require 'rails_helper'

RSpec.describe UpdatePersonJob, type: :job do
  describe "#perform" do
    let(:person) { create(:person) }
    context "when person_params are valid" do
      it "Should update a person" do
        UpdatePersonJob.new.perform(attributes_for(:person, f_name: "new name").merge("id" => person.id))

        expect(person.f_name).to_not eql person.reload.f_name
      end
    end

    context "when person_params are not valid" do
      it "should raise an error" do
        expect do
          UpdatePersonJob.new.perform(attributes_for(:person, f_name: nil).merge("id" => person.id))
        end.to raise_error(RuntimeError)
      end
    end
  end
end
