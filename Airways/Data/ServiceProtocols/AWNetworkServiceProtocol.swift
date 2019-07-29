import Foundation

protocol AWNetworkServiceProtocol {
    
    func get(path: String, parameters: [String: String]?, callback: @escaping (Data?, Error?) -> ())
    
}
