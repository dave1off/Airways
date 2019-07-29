import UIKit

protocol AWAirportsViewProtocol: class {
    
    var searchQuery: String { get }
    
    func startLoading()
    func loadingFailure()
    func airportsLoaded(airports: [AWAirportViewModel])
    
}

class AWAirportsViewImplementation: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var airportsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let airportsAdapter = AWAirportsTableAdapter()
    
    var presenter: AWAirportsPresenterProtocol!
    var router: AWAirportsRouterProtocol!
    
    var airports: [AWAirportViewModel] = []
    var searchQuery = ""
    
    init(configurator: AWAirportsConfiguratorProtocol) {
        super.init(nibName: "AWAirportsLayout", bundle: nil)
        
        configurator.configure(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        navigationItem.title = AWStrings.airports
        loadingIndicator.isHidden = true
        
        airportsAdapter.initialize(tableView: airportsTableView, inputProvider: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedRows = airportsTableView.indexPathsForSelectedRows ?? []
        
        for indexPath in selectedRows {
            airportsTableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension AWAirportsViewImplementation: AWAirportsViewProtocol {
    
    func airportsLoaded(airports: [AWAirportViewModel]) {
        self.airports = airports
        
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        airportsTableView.isHidden = false
        
        airportsAdapter.reload()
        airportsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func startLoading() {
        view.endEditing(true)
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        airportsTableView.isHidden = true
    }
    
    func loadingFailure() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        airportsTableView.isHidden = false
    }
    
}

extension AWAirportsViewImplementation: AWAirportsTableAdapterProtocol {
    
    func onSelect(airport: AWAirportViewModel) {
        let mapConfigurator = AWMapConfiguratorImplementation(source: airport)
        let mapView = AWMapViewImplementation(configurator: mapConfigurator)
        
        router.setMapView(view: mapView)
    }
    
}

extension AWAirportsViewImplementation: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchQuery = textField.text ?? ""
        presenter.onSearch()
        
        return true
    }
    
}
