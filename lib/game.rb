class Game
  attr_accessor :errors, :letters, :good_letters, :bad_letters, :status

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)

    if slovo.to_s.empty?
      abort "Загаданное слово отсутствует, нечего отгадывать. Закрываемся"
    end

    slovo.encode('UTF-8').split("")
  end


  def next_step(bukva)

    return if @status == -1 || @status == 1

    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if @letters.include?(bukva)
      @good_letters << bukva

      @status = 1 if @good_letters.uniq.sort == @letters.uniq.sort

    else

      @bad_letters << bukva

      @errors += 1

      @status = -1  if @errors >= 7

    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp.downcase
    end

    case letter
    when 'ё' then letter = "е"
    when 'й' then letter = "и"
    end

    next_step(letter)
  end
end
