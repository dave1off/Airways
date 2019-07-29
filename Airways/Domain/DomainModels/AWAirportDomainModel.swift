import Foundation
import CoreLocation

class AWAirportDomainModel {

    let name: String?
    let coordinates: CLLocationCoordinate2D
    let abbreviation: String
    
    init(name: String?, coordinates: CLLocationCoordinate2D, abbreviation: String) {
        self.name = name
        self.coordinates = coordinates
        self.abbreviation = abbreviation
    }
    
}
