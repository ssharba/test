require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do

  describe "CreatePeople", type: :request do

    describe "people create" do
      context "when the request format is not json" do

        let(:error_message) do
          { "Invalid Request Format" => "Request format should be json" }
        end

        before do
          post "/api/v1/people", headers: { "CONTENT_TYPE": "XML" }
        end

        it "should return a status of 400" do
          expect(response).to have_http_status(400)
        end

        it "should return an invalid request format in the body" do
          expect(json(response.body)).to eql error_message
        end

      end

      context "when the request format is json" do
        let(:person) { attributes_for(:person) }
        let(:invalid_person) { attributes_for(:person, f_name: "") }

        context "when the person is valid" do
          it "should let the job create the person" do
            allow(CreateNewPersonJob).to receive(:perform_async)

            post "/api/v1/people", params: person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(CreateNewPersonJob).to have_received(:perform_async)
          end

          it "should return a status of 200" do
            post "/api/v1/people", params: person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(response).to have_http_status 200
          end
        end

        context "when the person is invalid" do
          it "should let the job create the person" do
            allow(CreateNewPersonJob).to receive(:perform_async)

            post "/api/v1/people", params: invalid_person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(CreateNewPersonJob).to_not have_received(:perform_async)
          end

          it "should return a status of 200" do
            post "/api/v1/people", params: invalid_person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(response).to have_http_status 422
          end
        end
      end
    end
  end

  describe "ShowPeople", type: :request do
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

  describe "UpdatePeople", type: :request do
    describe "update people" do
      let!(:person) { create(:person) }

      context "when the request format is not json" do
        let(:error_message) do
          { "Invalid Request Format" => "Request format should be json" }
        end

        before do
          put "/api/v1/people/#{person.id}", headers: { "CONTENT_TYPE": "XML" }
        end

        it "should return a status of 400" do
          expect(response).to have_http_status(400)
        end

        it "should return an invalid request format in the body" do
          expect(json(response.body)).to eql error_message
        end

      end

      context "when the request format is json" do
        let(:person_attributes) { attributes_for(:person) }
        let(:invalid_person) { attributes_for(:person, f_name: "") }

        context "when the person is valid" do
          it "should let the job create the person" do
            allow(UpdatePersonJob).to receive(:perform_async)

            put "/api/v1/people/#{person.id}", params: person_attributes.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(UpdatePersonJob).to have_received(:perform_async)
          end

          it "should return a status of 200" do
            put "/api/v1/people/#{person.id}", params: person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(response).to have_http_status 200
          end
        end

        context "when the person is invalid" do
          it "should let the job create the person" do
            allow(UpdatePersonJob).to receive(:perform_async)

            put "/api/v1/people/#{person.id}", params: invalid_person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(UpdatePersonJob).to_not have_received(:perform_async)
          end

          it "should return a status of 200" do
            put "/api/v1/people/#{person.id}", params: invalid_person.to_json, headers: { "CONTENT_TYPE": "application/json" }

            expect(response).to have_http_status 422
          end
        end
      end
    end
  end
end
