require "word_finder"

class TextsController < ApplicationController
    def index
        @files = get_files
        @selected_file = nil
        @sequences = []
    end

    def show
        @files = get_files
        @selected_file = params[:id]
        @sequences = get_sequences
        render action: "index"
    end

    def create
        @files = get_files
        if params[:files].content_type == "text/plain"
            @selected_file = params[:files].original_filename.gsub('.txt','')
            file = params[:files]
            file_data = file.read
            @sequences = get_sequences_from_upload(file_data)
        else
            flash.alert = "Please upload a .txt file"
        end
        render action: "index"
    end

    private

    def get_files
        Dir.children('texts').map{|text| text.gsub('.txt','')}
    end

    def get_sequences
        path = "#{Rails.root}/texts/#{params[:id]}.txt"
        file = File.open(path)

        word_finder = WordFinder.new(text: file.read)
        word_finder.sequences
    end

    def get_sequences_from_upload(file_data)
        word_finder = WordFinder.new(text: file_data)
        word_finder.sequences
    end
end
