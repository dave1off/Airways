import Foundation

protocol AWAirportsConfiguratorProtocol {
    
    func configure(view: AWAirportsViewImplementation)
    
}

class AWAirportsConfiguratorImplementation: AWAirportsConfiguratorProtocol {

    func configure(view: AWAirportsViewImplementation) {
        let airportsRepository = AWAirportsRepository(networkService: AWNetworkService.shared)
        let getAirportsByCountryUseCase = AWGetAirportsByCountryUseCaseImplementation(repository: airportsRepository)
        
        let airportsPresenter = AWAirportsPresenterImplementation(
            getAirportsUseCase: getAirportsByCountryUseCase,
            view: view
        )
        
        let airportsRouter = AWAirportsRouterImplementation(view: view)
        
        view.presenter = airportsPresenter
        view.router = airportsRouter
    }
    
}
