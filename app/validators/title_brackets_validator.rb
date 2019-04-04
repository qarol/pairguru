class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:title] << "invalid field" unless balanced_brackets?(record.title)
  end

  private

  def balanced_brackets?(text)
    stack = []
    brackets = { "(" => ")", "[" => "]", "{" => "}" }
    text.chars.each_with_index do |char, i|
      if %w|( [ {|.include?(char)
        stack.push([char, i])
      elsif %w|) ] }|.include?(char)
        old_char, old_i = stack.pop
        return false if old_char.nil? || !brackets[old_char] == char || old_i + 1 == i
      end
    end
    stack.empty?
  end
end
