# #5 define "RandomData" as a module because it is a standalone library with no dependencies or inheritance requirements. Modules can be used as mixins to add functions to multiple classes
module RandomData
  # #6 define "random_paragraph" and set "sentences" to an array. We create four to six random sentences and append them to "sentences". We call "join" on "sentences" to combine each sentence in the array, passing a space to spearate each one
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  # #7 follow the same pattern as in #6 to create a sentence with a random number of words. After a sentence is generated, we call "capitalize" on it and append a period
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  # #8 define "random_word". Set "letters" to an array of letters a through z using to_a. Call shuffle! on "letters" in place using the bang. Join the zeroth through nth item in "letters". The nth item is the result of rand(3..8) which returns a random number greater than or equal to three and less than eight
  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end

  def self.random_number
    numbers = (0..9).to_a
    numbers.shuffle!
    numbers[0, rand(3..8)].join
  end
end
