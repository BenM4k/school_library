class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    true if @parent_permission || of_age?
  end

  private

  def of_age?
    true if @age >= 18
  end
end
