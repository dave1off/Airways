protocol AWAirportsRouterProtocol {
    
    func setMapView(view: AWMapViewImplementation)
    
}

class AWAirportsRouterImplementation: AWAirportsRouterProtocol {
    
    private weak var view: AWAirportsViewImplementation?
    
    init(view: AWAirportsViewImplementation) {
        self.view = view
    }
    
    func setMapView(view: AWMapViewImplementation) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
}
