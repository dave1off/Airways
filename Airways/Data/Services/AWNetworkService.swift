import Foundation

public enum AWNetworkServiceError: Error {
    
    case invalidRequestURL(String)
    case somethingWetWrong
    
}

final class AWNetworkService {
    
    static let shared = AWNetworkService()
    
    private let session = URLSession.shared
    
    private var baseURLComponentns: URLComponents {
        var components = URLComponents()
        
        components.scheme = "http"
        components.host = "places.aviasales.ru"
        
        return components
    }
    
    private init() { }

}

extension AWNetworkService: AWNetworkServiceProtocol {
    
    func get(path: String, parameters: [String: String]?, callback: @escaping (Data?, Error?) -> ()) {
        var urlComponents = baseURLComponentns
        
        urlComponents.path = path
        
        if let params = parameters {
            urlComponents.queryItems = []
            
            for (name, value) in params {
                urlComponents.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        
        guard let url = urlComponents.url else {
            callback(nil, AWNetworkServiceError.invalidRequestURL(urlComponents.string ?? ""))
            return
        }
        
        session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let _ = data, error == nil else {
                callback(nil, AWNetworkServiceError.somethingWetWrong)
                return
            }
            
            callback(data, error)
        }.resume()
    }

}
