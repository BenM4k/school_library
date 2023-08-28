require_relative 'person'

class Teacher < Person
  def initialize(id, name, age, specialization)
    super(id, name, age)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
