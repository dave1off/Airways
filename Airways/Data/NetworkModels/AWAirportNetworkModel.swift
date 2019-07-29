import Foundation
import CoreLocation

final class AWAirportNetworkModel: Decodable {
    
    let name: String?
    let coordinates: CLLocationCoordinate2D
    let abbreviation: String
    
    enum CodingKeys: String, CodingKey {
        
        case name = "airport_name"
        case coordinates
        case abbreviation = "iata"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let array = try values.decode([CLLocationDegrees].self, forKey: .coordinates)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coordinates = CLLocationCoordinate2D(latitude: array.first ?? 0, longitude: array.last ?? 0)
        abbreviation = try values.decode(String.self, forKey: .abbreviation)
    }
    
}

extension AWAirportNetworkModel {
    
    static func domainModel(from networkModel: AWAirportNetworkModel) -> AWAirportDomainModel {
        return AWAirportDomainModel(
            name: networkModel.name, coordinates: networkModel.coordinates, abbreviation: networkModel.abbreviation
        )
    }
    
}
