import Vapor
import VaporSQLite

let drop = Droplet()
try drop.addProvider(VaporSQLite.Provider.self)

drop.get { req in
    return try drop.view.make("welcome", [
        "message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("localization") { req in
    let json = JSON([
        "latitude": 50.058063,
        "longitude": 19.937875
        ])
    return json
}

drop.get("products") { req in
  let result = try drop.database?.driver.raw("SELECT * FROM Products")
  return try JSON(node: result)
}

drop.get("categories") { req in
  let result = try drop.database?.driver.raw("SELECT * FROM Categories")
  return try JSON(node: result)
}

drop.post("product") { req in
  guard let productId = req.json?["productId"]?.string else {
    fatalError("No productId")
  }

  let result = try drop.database?.driver.raw("SELECT * FROM Products WHERE id="+productId)
  return try JSON(node: result)
}

drop.run()
