import Foundation
import RealmSwift

class Category: Object {
    @objc var categoryId: Int = 0
    @objc var name: String = ""
    @objc var completed: Bool = false
    @objc var userId: Int = 0
    @objc var desc: String = ""
    @objc var id = UUID().uuidString
    
    static func make(basedOn json: JSON) throws -> Category {
        do {
            let realm = try Realm()
            let category = Category()
            if let categoryIdRaw = json["id"] as? String, let categoryId = Int(categoryIdRaw) {
                category.categoryId = categoryId
            }
            if let name = json["name"] as? String {
                category.name = name
            }
            if let desc = json["desc"] as? String {
                category.desc = desc
            }
            
            if Array(realm.objects(Category.self).filter { $0 == category }).isEmpty {
                try realm.write {
                    realm.add(category)
                }
                return category
            } else {
                throw AppError(description: "Object already in database")
            }
        } catch {
            print("Unable to create Category from JSON: \(error.localizedDescription)")
            throw error
        }
    }
}
