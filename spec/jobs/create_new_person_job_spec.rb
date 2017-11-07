require 'rails_helper'

RSpec.describe CreateNewPersonJob, type: :job do
  describe "#perform" do
    context "when person_params are valid" do
      it "Should create a new person" do
        expect do
          CreateNewPersonJob.new.perform(attributes_for(:person))
        end.to change(Person, :count).by 1
      end
    end

    context "when person_params are not valid" do
      it "should raise an error" do
        expect do
          CreateNewPersonJob.new.perform(attributes_for(:person, f_name: nil))
        end.to raise_error(RuntimeError)
      end
    end
  end
end
