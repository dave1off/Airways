import UIKit

protocol AWAirportsTableAdapterProtocol: class {
    
    var airports: [AWAirportViewModel] { get set }
    
    func onSelect(airport: AWAirportViewModel)
    
}

final class AWAirportsTableAdapter: NSObject {
    
    private weak var tableView: UITableView?
    private weak var inputProvider: AWAirportsTableAdapterProtocol?
    
    private var airports: [AWAirportViewModel] = []
    
    func initialize(tableView: UITableView?, inputProvider: AWAirportsTableAdapterProtocol?) {
        self.tableView = tableView
        self.inputProvider = inputProvider
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.separatorInset = .zero
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.register(
            UINib(nibName: AWAirportTableCell.identifier, bundle: nil),
            forCellReuseIdentifier: AWAirportTableCell.identifier
        )
    }
    
    func reload() {
        airports = inputProvider?.airports ?? []
        
        tableView?.reloadData()
    }

}

extension AWAirportsTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputProvider?.onSelect(airport: airports[indexPath.row])
    }
    
}

extension AWAirportsTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AWAirportTableCell.identifier,
            for: indexPath
        ) as! AWAirportTableCell
        
        
        let airport = airports[indexPath.row]
        
        cell.name?.text = airport.name
        cell.name?.textColor = AWColors.main
        
        return cell
    }
    
}
