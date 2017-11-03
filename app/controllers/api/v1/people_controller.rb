class Api::V1::PeopleController < ApplicationController

  def create
    person = Person.new(person_params)
    if person.valid?
      CreateNewPersonJob.perform_async(person_params.to_h)
      render json:  person, status: :ok
    else
      render json:  { errors: person.errors }, status: :unprocessable_entity
    end
  end

  private

  def person_params
    params.permit(:f_name, :l_name, :phone, :email, addresses_attributes: [:line1, :line2, :city, :state, :zip, :id])
  end
end
