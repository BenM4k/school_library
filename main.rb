%w[book classroom nameable
   person rental student
   teacher app].each { |file| require_relative file }

def main
  app = App.new
  loop do
    app.header
    choice = gets.chomp.to_i
    break unless choice != 7

    process_choice(app, choice)
  end
end

def process_choice(app, choice)
  case choice
  when 1 then app.list_all_books
  when 2 then app.list_all_people
  when 3 then app.create_person
  when 4 then app.create_book
  when 5 then app.create_rental
  when 6 then app.list_all_rentals
  else app.handle_invalid_input(choice)
  end
end
main
