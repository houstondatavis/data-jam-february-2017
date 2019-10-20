require 'decisiontree'
require 'pry'
require 'smarter_csv'

# Get an array of Hash
raw_data = SmarterCSV.process("weather.csv")

# TODO: Add more attributes
attributes = ["wind_direction", "wind_speed", "wind_speed_gust"]

training = []

raw_data.each do |hash|
  data_point = [hash[:wind_direction], hash[:wind_speed], hash[:wind_speed_gust], hash[:wind_friendly]]
  training << data_point
end

dec_tree = DecisionTree::ID3Tree.new(attributes, training, 'Windy', :continuous)
dec_tree.train

awesome_tree = dec_tree.instance_variable_get(:"@tree")

puts awesome_tree

dec_tree.graph("wind_graph")