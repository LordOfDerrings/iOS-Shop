import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocaliation()
    }
    
    func getLocaliation() {
        Repository().getLocalization { lati, long in
            let annotation = MKPointAnnotation.init()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lati, longitude: long)
            annotation.title = "Our store"
            self.mapView.showAnnotations([annotation], animated: true)
        }
    }
}
