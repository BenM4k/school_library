require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = rand(1000)
    @name = name
    @age = age
    @rentals = []
    @parent_permission = parent_permission
    super()
  end

  def can_use_service?
    true if @parent_permission || of_age?
  end

  def correct_name
    @name
  end

  def many?(rental)
    @rentals.push(student)
    rental.belongs_to = self
  end

  private

  def of_age?
    true if @age >= 18
  end
end

class Decorator < Nameable
  def initialize(nameabe)
    @nameabe = nameabe
    super()
  end

  def correct_name
    @nameabe.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end

class TrimmerDecorator < Decorator
  MAX_NAME_LENGTH = 10

  def correct_name
    original_name = super()
    original_name.length > MAX_NAME_LENGTH ? original_name[0, MAX_NAME_LENGTH] : original_name
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
