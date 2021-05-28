//
//  ViewController.swift
//  demo3
//
//  Created by user196209 on 4/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var moves_counter: UILabel!
    var moves = 0
    var game: Game!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        
        game = Game(view: self.view, numberOfCards: [16], images: [UIImage(named: "image0")!,UIImage(named: "image1")!,UIImage(named: "image2")!,UIImage(named: "image3")!,UIImage(named: "image4")!,UIImage(named: "image5")!,UIImage(named: "image6")!,UIImage(named: "image7")!], moves: moves_counter)
        
    }

//    func storeData(){
//        UserDefaults.standard.set("TEST", forKey: "Key")
//        let st : String? = UserDefaults.standard.string(forKey: "Key")
//        print("\(st)")
//    }

}

