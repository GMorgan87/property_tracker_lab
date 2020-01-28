require("pg")

class Property

attr_accessor :address, :value, :number_of_bedrooms, :year_built

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @address = options["address"]
    @value = options["value"]
    @number_of_bedrooms = options["number_of_bedrooms"]
    @year_built = options["year_built"]
  end


  def save()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
      })
    sql = "INSERT INTO properties
    (address, value, number_of_bedrooms, year_built)
    VALUES
    ($1, $2, $3, $4) RETURNING id"
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare("save", sql)
    @id = db.exec_prepared("save",values)[0]["id"].to_i()
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
    })
    sql = "DELETE FROM properties
    WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
    })
    sql = "UPDATE properties
    SET
    (address, value, number_of_bedrooms, year_built) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
    })
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    items = db.exec_prepared("all")
    db.close()
    return items.map {|item| self.new(item) }
  end

  def self.delete_all()
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
    })
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find(id_num)
    db = PG.connect({
      dbname: "property_tracker",
      host: "localhost"
    })
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id_num]
    db.prepare("find", sql)
    property_hash = db.exec_prepared("find", values)[0]
    # property_hash = properties[0]
    db.close()
    return  Property.new(property_hash)
  end



end
