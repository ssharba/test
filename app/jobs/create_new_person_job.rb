class CreateNewPersonJob
  include Sidekiq::Worker
  sidekiq_options queue:'create_person'

  def perform(person_params)
    person = Person.new(person_params)
    if person.save
      Rails.logger.info(person_params)
    else
      Rails.logger.error(action: "create", message: e.message)
      raise person.errors.full_messages
    end
  end
end
