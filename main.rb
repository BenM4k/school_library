require_relative 'app'

def main
  app = App.new
  loop do
    app.header
    choice = gets.chomp.to_i
    unless choice != 7
      app.save_lists
      break
    end

    app.run(choice)
  end
end
main
