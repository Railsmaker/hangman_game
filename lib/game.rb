class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  MAX_GAME_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @good_letters = []
    @bad_letters = []
    @status = :in_progress
    @errors = 0
  end

  def solved?
    @good_letters.uniq.sort == @letters.uniq.sort
  end

  def letter_repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def max_errors?
    @errors >= MAX_GAME_ERRORS
  end

  def get_letters(slovo)
    if slovo.to_s.empty?
      abort "Загаданное слово отсутствует, нечего отгадывать. Закрываемся"
    end
    slovo.encode('UTF-8').split("")
  end

  def next_step(letter)
    return if letter_repeated?(letter)
    
    if @letters.include?(letter)
      @good_letters << letter
    else
      @bad_letters << letter
      @errors += 1
    end

    @status = :won  if solved?
    @status = :lost if max_errors?
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp.to_s
      letter.downcase!
    end

    letter.gsub!("ё","е")
    letter.gsub!("й","и")

    next_step(letter)
  end
end
