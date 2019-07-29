import MapKit

protocol AWMapViewProtocol: class {
    
    func onLoadDestination(destination: AWAirportViewModel)
    
}

class AWMapViewImplementation: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var wayPolyline: MKGeodesicPolyline!
    var planeAnnotation: MKPointAnnotation!
    var planeAnnotationPosition = 0
    
    private let moveStep = 5
    private var timer = Timer()
    
    var presenter: AWMapPresenterProtocol!
    var router: AWMapRouterProtocol!
    
    init(configurator: AWMapConfiguratorProtocol) {
        super.init(nibName: "AWMapViewLayout", bundle: nil)
        
        configurator.configure(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = AWStrings.map
        
        mapView.delegate = self
        
        presenter.onViewDidLoad()
    }
    
    func updatePlanePosition() {
        guard planeAnnotationPosition + moveStep < wayPolyline.pointCount else {
            timer.invalidate()
            return
        }
        
        let points = wayPolyline.points()
        planeAnnotationPosition += moveStep
        let nextPoint = points[planeAnnotationPosition]
        
        planeAnnotation.coordinate = nextPoint.coordinate
    }
    
}

extension AWMapViewImplementation: AWMapViewProtocol {
    
    func onLoadDestination(destination: AWAirportViewModel) {
        let source = CLLocation(latitude: 59.8, longitude: 30.26)
        var coordinates = [source.coordinate, destination.coordinates]
        wayPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        mapView.addOverlay(wayPolyline)
        
        let planeAnnotation = MKPointAnnotation()
        planeAnnotation.title = "Plane"
        mapView.addAnnotation(planeAnnotation)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "SPB"
        sourceAnnotation.coordinate = source.coordinate
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = destination.abbreviation
        destinationAnnotation.coordinate = destination.coordinates
        
        mapView.addAnnotations([sourceAnnotation, destinationAnnotation])
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        self.planeAnnotation = planeAnnotation
        
        timer = Timer(timeInterval: 0.03, repeats: true) { timer in
            self.updatePlanePosition()
        }
        
        RunLoop.current.add(timer, forMode: .default)
    }
    
}

extension AWMapViewImplementation: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 3.0
        renderer.alpha = 0.5
        renderer.strokeColor = AWColors.main
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView
        
        if annotation.title == "Plane" {
            view = mapView.dequeueReusableAnnotationView(withIdentifier: "Plane")
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "Plane")
            
            view.image = #imageLiteral(resourceName: "airplane")
        } else {
            view = mapView.dequeueReusableAnnotationView(withIdentifier: "Country")
                ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "Country")
            
            let pointView = Bundle.main.loadNibNamed("PointView", owner: self, options: nil)?.first as! PointView
            
            pointView.title.text = annotation.title!
            view.frame = CGRect(x: 0, y: 0, width: 55, height: 25)
            view.addSubview(pointView)
        }
        
        return view
    }
    
}
