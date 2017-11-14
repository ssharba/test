class Api::V1::PeopleController < ApplicationController
  before_action :verify_request_format, only: [:create, :update]

  def index
    people = Person.all
    render json: people
  end

  def show
    person = Person.find_by(id: params[:id])

    if person
      render json: person, root: false
    else
      render json: { "No Person" => "We could not find any person with that id" }, status: 404
    end
  end

  def create
    person = Person.new(person_params)

    if person.valid?
      CreateNewPersonJob.perform_async(person_params.to_h)
      render json:  person, status: :ok
    else
      render json:  { errors: person.errors }, status: :unprocessable_entity
    end
  end

  def update
    Rails.logger.info("received_params: #{person_params}")
    person = Person.find(params[:id])
    person.assign_attributes(person_params)

    if person.valid?
      UpdatePersonJob.perform_async(person_params.to_h)
      render json: person, status: :ok
    else
      render json:  { errors: person.errors }, status: :unprocessable_entity
    end
  end


  private

  def person_params
    params.permit(:id, :f_name, :l_name, :phone, :email, addresses_attributes: [:line1, :line2, :city, :state, :zip, :id])
  end

  def verify_request_format
    unless request.content_type == 'application/json'
      render json: { "Invalid Request Format"=>"Request format should be json" }, status: 400
    end
  end
end
