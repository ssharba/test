class UpdatePersonJob
  include Sidekiq::Worker
  sidekiq_options queue:'update_person'

  def perform(person_params)
    person = Person.find(person_params["id"])
    if person.update(person_params)
      Rails.logger.info(person_params)
    else
      Rails.logger.error(action: "update", message: "#{person.errors.full_messages}")
      raise "#{person.errors.full_messages}"

    end
  end
end
