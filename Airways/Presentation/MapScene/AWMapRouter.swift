protocol AWMapRouterProtocol {

}

class AWMapRouterImplementation: AWMapRouterProtocol {
    
    private weak var view: AWMapViewImplementation?
    
    init(view: AWMapViewImplementation) {
        self.view = view
    }
    
}
