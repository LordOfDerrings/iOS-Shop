import Foundation
import RealmSwift

class Product: Object {
    @objc var catogoryId: Int = 0
    @objc var productId: Int = 0
    @objc var title: String = ""
    @objc var completed: Bool = false
    @objc var userId: Int = 0
    @objc var desc: String = ""
    @objc var id = UUID().uuidString
    @objc var imageURLString: String?
    @objc var price: String = ""
    
    var imageURL: URL? {
        return URL(string: imageURLString ?? "")
    }
    
    static func make(basedOn json: JSON) throws -> Product {
        do {
            let realm = try Realm()
            let product = Product()
            if let productId = json["id"] as? Int {
                product.productId = productId
            }
            if let categoryIdRaw = json["categoryId"] as? String, let categoryId = Int(categoryIdRaw) {
                product.catogoryId = categoryId
            }
            if let title = json["title"] as? String {
                product.title = title
            }
            if let imageURL = json["imgUrl"] as? String {
                product.imageURLString = baseURL.appendingPathComponent(imageURL).absoluteString
            }
            if let desc = json["desc"] as? String {
                product.desc = desc
            }
            if let price = json["price"] as? String {
                product.price = price
            }
            
            try realm.write {
                realm.add(product)
            }
            return product
        } catch {
            print("Unable to create Product from JSON: \(error.localizedDescription)")
            throw error
        }
    }
}
