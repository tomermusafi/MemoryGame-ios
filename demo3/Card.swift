//
//  Card.swift
//  demo3
//
//  Created by user196209 on 5/24/21.
//

import Foundation
import UIKit

public class Card{
    private var id: Int!
    private var image: UIImage!
    private var enable: Bool!
    private var discovered: Bool!
    
    init(id:Int, image:UIImage, enable:Bool, discovered:Bool) {
        self.id = id
        self.image = image
        self.enable = enable
        self.discovered = discovered
    }
    init() {
        
    }
    func getId() -> Int{
        return self.id
    }
    
    func setId(id: Int){
        self.id = id
    }
    
    func getImage() -> UIImage{
        return self.image
    }
    
    func setImage(image: UIImage){
        self.image = image
    }
    
    func isEnable() -> Bool{
        return self.enable
    }
    
    func setEnable(enable: Bool){
        self.enable = enable
    }
    
    func isDiscovered() -> Bool{
        return self.discovered
    }
    
    func setDiscovered(discavered: Bool){
        self.discovered = discavered
    }
}
