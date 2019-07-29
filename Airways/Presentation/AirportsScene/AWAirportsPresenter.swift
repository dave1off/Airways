import Foundation

protocol AWAirportsPresenterProtocol {
    
    func onSearch()
    
}

class AWAirportsPresenterImplementation: AWAirportsPresenterProtocol {
    
    private let getAirportsUseCase: AWGetAirportsByCountryUseCaseProtocol

    private weak var view: AWAirportsViewProtocol?
    
    init(getAirportsUseCase: AWGetAirportsByCountryUseCaseProtocol, view: AWAirportsViewProtocol) {
        self.getAirportsUseCase = getAirportsUseCase
        self.view = view
    }
    
    func onSearch() {
        let query = view?.searchQuery ?? ""
        
        view?.startLoading()
        
        getAirportsUseCase.getAirports(by: query) { response, error in
            guard let airports = response, error == nil else {
                AWExecutor.executeOnMain {
                    self.view?.loadingFailure()
                }
                
                return
            }
            
            let names = airports.map {
                AWAirportViewModel(
                    name: $0.name ?? AWStrings.noName,
                    coordinates: $0.coordinates,
                    abbreviation: $0.abbreviation
                )
            }
            
            AWExecutor.executeOnMain {
                self.view?.airportsLoaded(airports: names)
            }
        }
    }
    
}
