class WordFinder
    attr_accessor :text, :sequences

    SEQUENCE_LENGTH = 3
    LIMIT = 100

    def initialize(text)
        @text = scrub_text(text)
        @sequences = find_sequences
    end

    # remove unwanted characters from text
    # replace new line with space
    # remove unicode
    def scrub_text(txt)
        txt.to_s.downcase
        .encode("ASCII", "UTF-8", invalid: :replace, undef: :replace, replace: "")
        .gsub(/\R+/, ' ')
        .gsub(/[^a-z0-9\s]/i, "")
    end

    # initialize data structure and words
    def find_sequences
        word_sequences = Hash.new { |hsh, sequence| hsh[sequence] = 0 }
        words = self.text.split(/\s/).delete_if { |word| word.length.zero? }

        filter_and_sort_sequences(word_sequences, words)
    end

    # filter sequences and sort
    # increments hash key value when another sequence is found
    def filter_and_sort_sequences(word_sequences, words)
        i = 0
        while (words.length - SEQUENCE_LENGTH) >= i
            sequence = words[i, SEQUENCE_LENGTH].join(" ")
            word_sequences[sequence] += 1
            i += 1
        end
        
        word_sequences.sort_by { |_key, value| value }.reverse[0, LIMIT]
    end
end