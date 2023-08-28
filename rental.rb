class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date)
    @date = date
    @book = nil
    @person = nil
  end

  def belongs_to?(book)
    @book = book
  end

  def belongs_to_a_person?(person)
    @person = person
  end
end
