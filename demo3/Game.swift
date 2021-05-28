//
//  Game.swift
//  demo3
//
//  Created by user196209 on 5/24/21.
//

import Foundation
import UIKit

public class Game{
    
    private var first: Card!
    private var second: Card!
    private var tempBtn: UIButton!
    private var cards = [Card]()
    private var points: Int!
    private var numberOfCards=[Int]()
    private var images = [UIImage]()
    private var clickCounter: Int!
    private var level: Int!
    private var moves: UILabel!
    private var view: UIView!
    private var moves_counter: Int!
    private var my_view:UIView!
    init(){
        
    }
    init(view: UIView, numberOfCards:[Int], images:[UIImage], moves: UILabel){
        self.view = view
        moves_counter = 0
        self.points = 0
        self.clickCounter = 0
        self.moves = moves
        self.numberOfCards = numberOfCards
        self.images = images
        self.level = 0
        self.cards = creatCards();
        createBoard();
    }
    
    func creatCards() -> [Card]{
        var cards = [Card]()
        let length = self.numberOfCards[self.level]
        for index in 0...(length/2)-1 {
            let card = Card()
            card.setImage(image: images[index])
            card.setEnable(enable: true)
            card.setDiscovered(discavered: false)
            cards.append(card)
            let card2 = Card()
            card2.setImage(image: images[index])
            card2.setEnable(enable: true)
            card2.setDiscovered(discavered: false)
            cards.append(card2)
        }
        cards.shuffle()
        for index in 0...length - 1{
            cards[index].setId(id: index)
        }
        return cards
    }
    
    func createBoard(){
        var id = 0
        let length = (self.numberOfCards[self.level]/4) - 1
        self.my_view = self.view.viewWithTag(1)!
        for i in 0...3{
            let xx = Int(view.frame.size.width)/4 * i
            for j in 0...length{
        
                let yy = Int(view.frame.size.width)/4 * j
                let height = (Int(view.frame.size.width)/4) - 3
                let width = (Int(view.frame.size.width)/4) - 3
                let button = UIButton(frame: CGRect(x: xx+3, y: yy+3, width: width , height: height))
                button.accessibilityIdentifier = "\(id)"
                button.setImage(UIImage(named: "image"), for: .normal)
      
                button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
                //buttonAction(button)
                
                id = id + 1
                my_view.addSubview(button)
        
      
            }
            
        }
        
    }
    
     @objc func buttonAction(_ sender: UIButton!) {
//        self.moves_counter = self.moves_counter + 1
//        self.moves.text = "\(moves_counter ?? 0)"
        let btn_index = Int(sender.accessibilityIdentifier!)!
//        sender.setImage(self.cards[btn_index].getImage(), for: .normal)
        let card = self.cards[btn_index]
        print(card.isEnable())
        print("xxx")
        print(!card.isDiscovered())
        print("yyy")
        print(self.clickCounter < 2)
        print("zzz")
        if(card.isEnable() && !card.isDiscovered() && self.clickCounter < 2){
            self.moves_counter = self.moves_counter + 1
            self.moves.text = "\(moves_counter ?? 0)"
            sender.setImage(self.cards[btn_index].getImage(), for: .normal)
            card.setEnable(enable: false);
            self.clickCounter = self.clickCounter + 1
            if(self.first == nil){
                self.tempBtn = sender
            }
            switch checkMatch(card: card){
            case 0:
                self.first = nil
                self.second = nil
                self.points = self.points + 2
                releaseCards()
            break
            case 1:break
            case -1:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.tempBtn.setImage(UIImage(named: "image")!, for: .normal)
                    sender.setImage(UIImage(named: "image")!, for: .normal)
                    self.first = nil
                    self.second = nil
                    self.releaseCards()
                }
                break
                
            default: break
                
            }
        }
        if(clickCounter >= 2){
            disableCards()
        }
        checkIfFoundAll()
    }
    
    func checkMatch(card: Card) -> Int{
        if(first == nil){
            first = card
            return 1
        }else if(second == nil){
            second = card
        }
        if(second != nil){
            if(first.getImage() == second.getImage()){
                cards[first.getId()].setDiscovered(discavered: true)
                cards[second.getId()].setDiscovered(discavered: true)
                return 0
            }
        }
        return -1
    }
    
    func releaseCards(){
        for card in cards {
            if(!card.isDiscovered()){
                card.setEnable(enable: true)
            }
        }
        clickCounter = 0
    }
    
    func disableCards(){
        for card in cards {
            card.setEnable(enable: false)
        }
    }
    
    func checkIfFoundAll(){
        if(points == numberOfCards[level]){
            self.moves_counter = 0
            for v in self.my_view.subviews{
                v.removeFromSuperview()
            }
            self.moves.text = "\(moves_counter!)"
            self.points = 0
            self.clickCounter = 0
            self.cards = creatCards()
            createBoard()
        }
    }
    
   
    
    
    
}
