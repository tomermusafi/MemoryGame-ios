//
//  HomeViewController.swift
//  demo3
//
//  Created by user196209 on 5/29/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func goToPlayPage(){
        let vc = storyboard?.instantiateViewController(identifier: "play") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction func goToTopTenPage(){
        let vc = storyboard?.instantiateViewController(identifier: "TopTen") as! TopTenViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    

}
