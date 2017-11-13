require 'rails_helper'

RSpec.describe "UpdatePeople", type: :request do
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
