class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  def belongs_to?
    @book = self
  end

  def belongs_to_a_person?
    @person = self
  end
end
