require 'spec_helper'
require 'word_finder'

describe WordFinder do
    describe "initialize" do

        before do
            sample_text = "hi IÀ LOVEÀ SANDWICHESÀ -- i also like pickles --  (I LOVE SANDWICHES!!) furthermore i love sandwiches. and i love sandwiches. also sandwiches i love. i also like pickles and also like pickles."

            @word_finder = WordFinder.new(text: sample_text)
        end

        describe "scrub_text" do
            it "removes unwanted characters" do
                original_text = "(I LOVE SANDWICHES!!)"
                expected_text = "i love sandwiches"
                expect(@word_finder.scrub_text(original_text)).to eq(expected_text)
            end

            it "replaces new line with spasce" do
                original_text = "I love\nsandwiches."
                expected_text = "i love sandwiches"
                expect(@word_finder.scrub_text(original_text)).to eq(expected_text)
            end

            it "preserves contractions" do
                original_text = "can't"
                expected_text = "cant"
                expect(@word_finder.scrub_text(original_text)).to eq(expected_text)
            end

            it "removes unicode" do
                original_text = "ÀuÁnÂiÃcÄoÅdÆe"
                expected_text = "unicode"
                expect(@word_finder.scrub_text(original_text)).to eq(expected_text)
            end
        end

        describe "find_sequences" do
            it "finds the correct number of sequences" do
                target_sequence = "i love sandwiches"
                target_count = 4
                expect(@word_finder.sequences[0][0]).to eq(target_sequence)
                expect(@word_finder.sequences[0][1]).to eq(target_count)
            end

            it "sorts high to low" do
                first = "i love sandwiches"
                second = "also like pickles"
                expect(@word_finder.sequences[0][0]).to eq(first)
                expect(@word_finder.sequences[1][0]).to eq(second)
            end
        end
    end
end