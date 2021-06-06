//
//  GameOverViewController.swift
//  demo3
//
//  Created by user196209 on 6/5/21.
//

import UIKit
import CoreLocation

class GameOverViewController: UIViewController {

    @IBOutlet weak var movesLable: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var nameEditor: UITextField!
    
    @IBOutlet weak var saveBTN: UIButton!
    
    let locationManager = CLLocationManager()
    
    var lat: Double?
    var lng: Double?
        
    var myRecord: [Record] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let user = UserDefaults.standard
        if let record = user.data(forKey: "record"){
            let decoder = JSONDecoder()
            myRecord = try! decoder.decode([Record].self, from: record)
                
            print("lllll")
            print("\(myRecord[0].moves)")
            movesLable.text = "\(myRecord[0].moves)"
            timeLable.text = "\(myRecord[0].time)"
            
        }
       
        
    }
    @IBAction func goToHomePage(){
        self.setNewRecord()
        let vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func setNewRecord(){
        var records = getRecords()
        if records.count < 10{
            records.append(Record(time: self.myRecord[0].time, moves: self.myRecord[0].moves, name: self.nameEditor.text ?? "", lat: self.lat ?? 0.0, lng: self.lng ?? 0.0))
            records = records.sorted{$0.time < $1.time}
        }else {
            records.append(Record(time: self.myRecord[0].time, moves: self.myRecord[0].moves, name: self.nameEditor.text ?? "", lat: self.lat ?? 0.0, lng: self.lng ?? 0.0))
            records = records.sorted{$0.time < $1.time}
            records.removeLast()
            
        }
        print(records)
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(records)
        let user = UserDefaults.standard
        user.set(jsonData,forKey: "records")
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    

}

extension GameOverViewController :CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
        }
    }
}
