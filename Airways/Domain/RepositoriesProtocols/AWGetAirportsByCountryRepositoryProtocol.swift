import Foundation

protocol AWGetAirportsByCountryRepositoryProtocol {

    func getAirports(by country: String, callback: @escaping ([AWAirportDomainModel]?, Error?) -> ())
    
}
