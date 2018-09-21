import Foundation

typealias JSON = [String: Any]

let baseURL = URL(string: "http://localhost:8080")!

class APIService {
    
    private func performRequest(_ url: URL, completion: @escaping([JSON]?, Error?)->()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var json: [JSON]?
            var error = error
            if let data = data {
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [JSON]
                } catch let serializationError {
                    error = serializationError
                }
            }
            completion(json, error)
        }
        task.resume()
    }
    
    // MARK: - Endpoints
    
    func getCategoriesData(completionHandler: @escaping([JSON]?, Error?)->()) {
        let url = baseURL.appendingPathComponent("/categories")
        performRequest(url, completion: completionHandler)
    }
    
    func getProductsData(for category: Category, completionHandler: @escaping ([JSON]?, Error?)->()) {
        let url = baseURL.appendingPathComponent("/products")
        performRequest(url, completion: completionHandler)
    }
    
    func getLocalization(completionHandler: @escaping(JSON?, Error?)->()) {
        let url = baseURL.appendingPathComponent("/localization")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var json: JSON?
            var error = error
            if let data = data {
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON
                } catch let serializationError {
                    error = serializationError
                }
            }
            completionHandler(json, error)
        }
        task.resume()
    }
}
