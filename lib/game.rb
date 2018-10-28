class Game
  attr_accessor :errors, :letters, :good_letters, :bad_letters, :status

  NUMBER_GAME_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @good_letters = []
    @bad_letters = []
    @status = 0
    @errors = 0
  end

  def get_letters(slovo)
    return slovo.encode('UTF-8').split("") unless slovo.to_s.empty?
    abort "Загаданное слово отсутствует, нечего отгадывать. Закрываемся"
  end

  def next_step(bukva)

    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if @letters.include?(bukva)
      @good_letters << bukva
    else
      @bad_letters << bukva
      @errors += 1
    end

    @status = 1 if @good_letters.uniq.sort == @letters.uniq.sort
    @status =-1 if @errors >= NUMBER_GAME_ERRORS
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp.downcase.to_s
    end

    letter == 'ё' ? letter = 'е' : letter
    letter == 'й' ? letter = 'и' : letter

    next_step(letter) unless @status == -1 || @status == 1
  end
end
