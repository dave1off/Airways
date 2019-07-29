import Foundation

protocol AWMapPresenterProtocol {
    
    func onViewDidLoad()
    
}

class AWMapPresenterImplementation: AWMapPresenterProtocol {
    
    private weak var view: AWMapViewProtocol?
    
    private let source: AWAirportViewModel
    
    init(source: AWAirportViewModel, view: AWMapViewProtocol) {
        self.source = source
        self.view = view
    }
    
    func onViewDidLoad() {
        view?.onLoadDestination(destination: source)
    }
    
}
