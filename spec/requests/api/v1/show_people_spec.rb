require 'rails_helper'

RSpec.describe "ShowPeople", type: :request do
  describe "show" do

    context "when the right id is passed" do
      context "when the person has addresses" do
        let!(:person_with_address) { create(:person_with_addresses) }

        before do
          get "/api/v1/people/#{person_with_address.id}"
        end

        it { expect(response).to have_http_status 200 }

        it "should return the person with its addresses" do
          expect(JSON.parse(response.body)).to have_key("addresses")
        end

        it "should have 2 addresses" do
          expect(JSON.parse(response.body)["addresses"].count).to eql 2
        end
      end

      context "when the person does not have addresses" do
        let!(:person_without_address) { create(:person) }

        before do
          get "/api/v1/people/#{person_without_address.id}"
        end

        it { expect(response).to have_http_status 200 }

        it "should return the person with its addresses" do
          expect(JSON.parse(response.body)).to have_key("addresses")
        end

        it "should have no addresses" do
          expect(JSON.parse(response.body)["addresses"].count).to eql 0
        end
      end
    end

    context "when an id that does not exist is passed" do
      before do
        get "/api/v1/people/1000"
      end

      it { expect(response).to have_http_status(404) }
    end
  end
end
