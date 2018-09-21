import Foundation

struct AppError: Error {
    let description: String
    
    var localizedDescription: String { return description }
}
