require 'decisiontree'
require 'pry'
require 'smarter_csv'

# Get an array of Hash
raw_data = SmarterCSV.process("flights.csv")

# TARGET_PREDICT = "aircrafttype"

TARGET_PREDICT = "seats_cabin_coach"

# TODO: Add more attributes
attributes = ["seats_cabin_first", "seats_cabin_business"]

training = []

raw_data.each do |hash|
  data_point = []
  attributes.each do |attribute|
    data_point << hash[:"#{attribute}"]
  end
  data_point << hash[:"#{TARGET_PREDICT}"]

  training << data_point
end

# dec_tree = DecisionTree::ID3Tree.new(attributes, training, 'B787', :continuous)

dec_tree = DecisionTree::ID3Tree.new(attributes, training, 0, :continuous)
dec_tree.train

awesome_tree = dec_tree.instance_variable_get(:"@tree")

puts awesome_tree

dec_tree.graph("airplane_graph")