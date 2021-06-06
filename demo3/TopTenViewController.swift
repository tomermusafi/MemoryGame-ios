//
//  TopTenViewController.swift
//  demo3
//
//  Created by user196209 on 6/5/21.
//

import UIKit
import MapKit

class TopTenViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    var annontations: [MKPointAnnotation]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        annontations = []
        for record in getRecords(){
            let annontation = MKPointAnnotation()
            annontation.coordinate = CLLocationCoordinate2D(latitude: record.lat, longitude: record.lng)
            annontation.title = record.name
            mapView.addAnnotation(annontation)
            annontations.append(annontation)
        }
        
        
         
        
        
        
    }
    
    @IBAction func goToHomePage(){
        let vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func getRecords() -> [Record]{
        let userDefault = UserDefaults.standard
        if let records = userDefault.data(forKey: "records"){
            let decoder = JSONDecoder()
            return try! decoder.decode([Record].self, from: records)
        }else{
            return []
        }
    }

    

}

extension TopTenViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = MKCoordinateRegion(center: annontations[indexPath.row].coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
    }
}
extension TopTenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getRecords().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! MyTableViewCell
        cell.name.text = getRecords()[indexPath.row].name
        cell.time.text = getRecords()[indexPath.row].time
        return cell
    }
    
    
}
