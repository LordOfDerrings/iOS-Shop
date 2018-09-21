import Foundation
import RealmSwift

class Repository {
    
    var service = APIService()
    
    func getCategories(_ completion: @escaping([Category])->()) {
        let categories = DatabaseService().fetchCategories()
        completion(categories)
        
        service.getCategoriesData() { json, error in
            guard error == nil else { return }
            DispatchQueue.main.async {
                let categories: [Category] = json?.compactMap { try? Category.make(basedOn: $0 )} ?? []
                if categories.count > 0 {
                    completion(categories)
                }
            }
        }
    }
    
    func getProducts(of category: Category, _ completion: @escaping([Product])->()) {
        var products = DatabaseService().fetchProducts(of: category).filter { $0.catogoryId == category.categoryId }
        completion(products)
        
        service.getProductsData(for: category) { json, error in
            guard error == nil else { return }
            DispatchQueue.main.async {
                products = json?.compactMap { try? Product.make(basedOn: $0 )} ?? []
                products = products.filter { $0.catogoryId == category.categoryId }
                if products.count > 0 {
                    completion(products)
                }
            }
        }
    }
    
    func getLocalization(_ completion: @escaping(Double, Double)->()) {
        service.getLocalization(completionHandler: { json, error in
            if let json = json,
                let lati = json["latitude"] as? Double,
                let long = json["longitude"] as? Double {
                
                completion(lati, long)
            }
        })
    }
    
}
