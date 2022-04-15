//
//  MapsViewController.swift
//  InnovationOneMaps
//
//  Created by Matheus Henrique on 08/04/22.
//

import UIKit
import MapKit


class MapsviewController: UIViewController {
    
    @IBOutlet weak var MKMapView: MKMapView!
    
    let locationManeger: CLLocationManager = CLLocationManager()
    
    var selectAdress: Address? = nil
    
    @IBOutlet weak var AdressTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManeger.delegate = self
        locationManeger.requestWhenInUseAuthorization() //popup pedindo autorização
        
        if CLLocationManager.locationServicesEnabled() {
            locationManeger.desiredAccuracy = kCLLocationAccuracyBest // local exato onde vc esta , cujo consome muita bateria
            locationManeger.requestLocation() //pede onde vc esta no mapa
        }
    }
    
    override func viewDidAppear(_ animated: Bool) { //metodo q mostra posicao correta do USER
        super.viewDidAppear(false)
        MKMapView.showsUserLocation = true
        locationManeger.startUpdatingLocation()
    }
    
    func TappedShowAdress(_ sender: Any) {
        getPossibleAddressesFromText()
    }
    
    private func getPossibleAddressesFromText() {
        var addresses: [Address] = []
        CLGeocoder().geocodeAddressString(AdressTextField.text!) { (placemarks, error) in
            if error == nil {
                for placemark in placemarks! {
                    addresses.append(self.convertToAdress(placemark: placemark))
                }
                
                self.TappedShowAdressessTable(addresses: addresses)
            } else {
                let controller = UIAlertController(title: "Error", message: "Problem trying to fetch adresses from the text", preferredStyle: UIAlertController.Style.alert)
                self.present(controller, animated: true)
                
            }

        }
    }
    
    private func convertToAdress(placemark: CLPlacemark) -> Address {
        return Address(name: placemark.postalAddress!.street, placemark: placemark, postalAddress: placemark.postalAddress!);
    }
    
    private func showAddressesTable(addresses: [Address]) {
        let addressVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddressesTableViewController") as! AddressesTableViewController
        addressesVC.addresses = addresses
        addressesVC.selectedAddress = { address in
         self.selectedAddress = address
         }
     self.navigationController?.pushViewController(addressVC, animated: true)
        
    }
    
}

extension MapsviewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//sempre que se movimenta esse array e chamado e retorna
        let location = locations.last
        MKMapView.centerCoordinate = location!.coordinate
        let region = MKMapView.regionThatFits(MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 600.0, longitudinalMeters: 600.0))
        MKMapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {// metodo de informa o error de falta de deteccao do gps
        print(error.localizedDescription)
    }
}
