import Foundation

protocol AWMapConfiguratorProtocol {
    
    func configure(view: AWMapViewImplementation)
    
}

class AWMapConfiguratorImplementation: AWMapConfiguratorProtocol {
    
    private let source: AWAirportViewModel
    
    init(source: AWAirportViewModel) {
        self.source = source
    }
    
    func configure(view: AWMapViewImplementation) {
        let airportsPresenter = AWMapPresenterImplementation(
            source: source,
            view: view
        )
        
        let airportsRouter = AWMapRouterImplementation(view: view)
        
        view.presenter = airportsPresenter
        view.router = airportsRouter
    }
    
}
