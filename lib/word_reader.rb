class WordReader

  def read_from_file(file_name)

    return unless File.exist?(file_name)
    return if File.zero?(file_name)

    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close

    lines.map do |item|
      item.gsub!("ё","е")
      item.gsub!("й","и")
    end

    return lines.sample.chomp
  end
end
