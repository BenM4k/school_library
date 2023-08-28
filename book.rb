class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def many?(rental)
    @rentals.push(rental)
    rental.belongs_to = self
  end
end
