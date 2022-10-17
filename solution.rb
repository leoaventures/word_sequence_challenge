require "./lib/word_finder"

# handle regular ruby command input
# One file: `ruby ./solution.rb texts/moby_dick.txt`
# Multiple files: `ruby solution.rb texts/moby-dick.txt texts/brothers-karamazov.txt`
def process_from_ruby_command
    combined_text = ""
    ARGV.each do |a|
        file = File.open(a.strip.to_s)
        combined_text += file.read
    end

    output_sequences(combined_text)
end

# handle input via stdin
# One file: `cat texts/moby-dick.txt | ruby solution.rb`
# Multiple files: `cat texts/*.txt | ruby solution.rb`
def process_from_stdin_command
    lines = []
    while a = gets
        lines << a.chomp
    end

    if lines.length > 0
        output_sequences(lines.join(" "))
    end
end

# insantiate WordFinder class to print the most common sequences
def output_sequences(text)
    word_finder = WordFinder.new(text: text)
    word_finder.sequences.each do |sequence, count|
        puts "#{sequence} - #{count}"
    end
end

# process input from user
if ARGV && ARGV[0]
    process_from_ruby_command
else
    process_from_stdin_command
end
