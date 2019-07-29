import Foundation

protocol AWGetAirportsByCountryUseCaseProtocol {
    
    func getAirports(by country: String, callback: @escaping ([AWAirportDomainModel]?, Error?) -> ())
    
}

class AWGetAirportsByCountryUseCaseImplementation: AWGetAirportsByCountryUseCaseProtocol {
    
    private let repository: AWGetAirportsByCountryRepositoryProtocol
    
    init(repository: AWGetAirportsByCountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAirports(by country: String, callback: @escaping ([AWAirportDomainModel]?, Error?) -> ()) {
        repository.getAirports(by: country, callback: callback)
    }
    
}
