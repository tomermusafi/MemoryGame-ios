//
//  ViewController.swift
//  demo3
//
//  Created by user196209 on 4/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var time: UILabel!
    var time_counter: Int!
    var timer: Timer!
    
    @IBOutlet weak var moves_counter: UILabel!
    var game: Game!
    
    var timeForRecord = ""
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        timer = nil
        time_counter = 0
        
        game = Game(call_back: self,view: self.view, numberOfCards: [16], images: [UIImage(named: "image0")!,UIImage(named: "image1")!,UIImage(named: "image2")!,UIImage(named: "image3")!,UIImage(named: "image4")!,UIImage(named: "image5")!,UIImage(named: "image6")!,UIImage(named: "image7")!], moves: moves_counter)
        
    }
    
    
    func startTimer(){
        time.text = "00:00"
        timer = Timer()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)

    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerCount(){
        time_counter  = time_counter + 1
        var my_time = ""
        let sec = String(format: "%02d",(time_counter%60))
        let min = String(format: "%02d",(time_counter/60))
        my_time = "\(min):\(sec)"
        time.text = "\(my_time)"
        timeForRecord = "\(my_time)"
    }

//    func storeData(){
//        UserDefaults.standard.set("TEST", forKey: "Key")
//        let st : String? = UserDefaults.standard.string(forKey: "Key")
//        print("\(st)")
//    }

}

extension ViewController : GameCallBack{
    func gameStarted() {
        startTimer()
    }
    
    func gameEnded() {
        stopTimer()
        let record = [Record(time: timeForRecord, moves: self.game.getMoves(), name: "", lat: 0.0, lng: 0.0)]
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(record)
        let user = UserDefaults.standard
        user.set(jsonData,forKey: "record")
        let vc = storyboard?.instantiateViewController(identifier: "GameOver") as! GameOverViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
