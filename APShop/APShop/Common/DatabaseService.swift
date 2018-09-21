import Foundation
import RealmSwift

class DatabaseService {
    
    func fetchCategories() -> [Category] {
        do {
            let realm = try Realm()
            let categoriesResult = realm.objects(Category.self)
            return Array(categoriesResult)
        } catch {
            print("Unable to load Categories from database: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchProducts(of category: Category) -> [Product] {
        do {
            let realm = try Realm()
            let productsResult = realm.objects(Product.self).filter { $0.catogoryId == category.categoryId }
            return Array(productsResult)
        } catch {
            print("Unable to load Category \(category.name) Products from database: \(error.localizedDescription)")
            return []
        }
    }
}
