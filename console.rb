require("pry-byebug")
require_relative("models/property")

Property.delete_all()

prop1 = Property.new({
  "address" => "1 street road",
  "value" => 100000,
  "number_of_bedrooms" => 3,
  "year_built" => 1900
  })
  prop1.save()

  prop2 = Property.new({
    "address" => "2 street road",
    "value" => 200000,
    "number_of_bedrooms" => 5,
    "year_built" => 1901
    })
    prop2.save()

    binding.pry
    nil
