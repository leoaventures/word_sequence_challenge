# WORD SEQUENCE FINDER

App written for New Relic coding challenge by Leo Chen.
This app can scan one or more text files to find the most 100 most common 3 word phrases.

### Setup
This app can be run in 3 ways. There are two text files in the /text folder.
1. **Ruby command line**
One file: `ruby ./solution.rb texts/moby_dick.txt`
Multiple files: `ruby solution.rb texts/moby-dick.txt texts/brothers-karamazov.txt`

2. **STDIN**
One file: `cat texts/moby-dick.txt | ruby solution.rb`
Multiple files: `cat texts/*.txt | ruby solution.rb`

3. **Rails App**
- There is a bonus rails app that runs on Ruby 3.1.2 & Rails 6.1.7
- This provides a graphical interface to view results from the pre-loaded text files or upload a new text file
`bundle install`
`rails s`
`open http://localhost:3000/ in browser`

### Structure
- Primary algorithm logic is in a module `lib/word_finder.rb`
    - Reusable by the command line solution as well as the rails app
- Command line solution is in `solution.rb`
- Rails app is created in `app` folder and uses `app/controllers/text_controller` and `app/views/texts` to drive user flow
- Tests are in the `rspec` folder

### Running Tests
- Unit tests are written in RSpec.
- These the text formatting logic (removing unwanted characters, etc.) as well as the filtering logic to find the most frequent word sequences.
- Use the `rspec` command to run the tests.
`bundle install`
`rspec`

### What would I do next?
- More robust ways of cleaning the text. maybe use a gem or library
- Better error handling around command line inputs - ex: if there is a typo or mistake
- Add more analytics to the rails app: total lines, total words, processing time, etc.

### Any bugs I am aware of?
- The counts I generated are slightly different from the suggested counts
- Uploading a file manually was tested with clean and reasonably sized text files only, there might be issues with different files sizes or with corrupt data