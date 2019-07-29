import Foundation

final class AWAirportsRepository {
    
    private let networkService: AWNetworkServiceProtocol
    private let decoder = JSONDecoder()
    
    init(networkService: AWNetworkServiceProtocol) {
        self.networkService = networkService
    }

}

extension AWAirportsRepository: AWGetAirportsByCountryRepositoryProtocol {
    
    func getAirports(by country: String, callback: @escaping ([AWAirportDomainModel]?, Error?) -> ()) {
        networkService.get(
            path: "/places",
            parameters: [
                "term": country,
                "locale": "ru"
            ]
        ) { data, error in
            guard let responseData = data, error == nil else {
                callback(nil, error)
                return
            }
            
            guard let airports = try? self.decoder.decode([AWAirportNetworkModel].self, from: responseData) else {
                callback(nil, error)
                return
            }
            
            let domainAirports = airports.map { AWAirportNetworkModel.domainModel(from: $0) }
            
            callback(domainAirports, nil)
        }
    }
    
}
