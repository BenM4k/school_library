require_relative 'app'

def main
  app = App.new
  display = Display.new
  loop do
    display.header
    choice = gets.chomp.to_i
    unless choice != 7
      app.save_lists
      break
    end

    app.run(choice)
  end
end
main
