class ResultPrinter
  def initialize
    @status_image = []
    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= Game::MAX_GAME_ERRORS
      file_name = current_path + "/image/#{counter}.txt"

      if File.exist?(file_name)
        File.open(file_name, 'r:UTF-8') {|f|  @status_image << f.read }
      else
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls
    puts "\n\nСлово: " + get_word_for_print(game.letters, game.good_letters).to_s
    puts "Ошибки: " + game.bad_letters.join(", ").to_s
    print_viselitsa(game.errors)

    case game.status
    when :lost
      puts "Вы проиграли :( \nЗагаданное слово было: #{game.letters.join('')}\n\n"
    when :won
      puts "\nПоздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: (7 - #{game.errors})"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ''
    for i in letters do
      good_letters.include?(i) ? result += "#{i.upcase} "  : result += "__ "
    end
    result
  end

  def cls
    system("clear") || system("cls")
  end
end
