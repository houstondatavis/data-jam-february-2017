require 'decisiontree'
require 'pry'
require 'smarter_csv'

# Get an array of Hash
raw_data = SmarterCSV.process("weather.csv")

TARGET_PREDICT = "visibility"
DEFAULT = 1

attributes = ["cloud_altitude","wind_friendly"]

# attributes = ["cloud_altitude","wind_friendly", "temp_air", "wind_speed"]

training = []

raw_data.each do |hash|
  data_point = []
  attributes.each do |attribute|
    data_point << hash[:"#{attribute}"]
  end
  data_point << hash[:"#{TARGET_PREDICT}"]

  training << data_point
end

dec_tree = DecisionTree::ID3Tree.new(attributes, training, DEFAULT, cloud_altitude: :continuous, wind_friendly: :discrete)
dec_tree.train

# DEC TREE IS BROUGHT TO YOU BY THE POWER OF THE GARDEN OF FORKING PATHS!' DO NOT RELY ON THIS EXPLORTATORY ANALYSIS! GET A BRAND NEW DATASET AND TRY AGAIN!

awesome_tree = dec_tree.instance_variable_get(:"@tree")

dec_tree.graph("weather_graph")

puts "DETERMINE OVERFITTING OF GARDEN OF FORKING PATHS"

correct = 0
total = 0

training.each do |test|
  decision = dec_tree.predict(test)
  if decision = test.last
    correct += 1
  end
  total += 1
end

puts "#{correct} correct!"
puts "#{total} total!"
puts "#{(correct.to_f/total)*100}% correct."