//
//  ViewController.swift
//  Bloggle
//
//  Created by susan lovaglio on 11/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var word = [String]()
    var pieces = [String]()
    var winningWords = [String]()
    
    @IBOutlet weak var holder: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var ten: UIButton!
    @IBOutlet weak var eleven: UIButton!
    @IBOutlet weak var twelve: UIButton!
    @IBOutlet weak var thirteen: UIButton!
    @IBOutlet weak var fifteen: UIButton!
    @IBOutlet weak var sixteen: UIButton!
    @IBOutlet weak var fourteen: UIButton!
    @IBOutlet weak var six: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointsLabel.isHidden = true
        
        for _ in 0...15{
            
            pieces.append(randoLetter())
        }
        
            let stringPieces = pieces.joined(separator: "")
        print(stringPieces)
            let stringUrl = "https://api.codebox.org.uk/boggle/\(stringPieces)"
            let url = URL(string: stringUrl)
            let session = URLSession.shared
        
        
            let task = session.dataTask(with: url!) { (data, response, error) in
                
                let results = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String]
                
                if let unwrappedresults = results {
                    
                    self.winningWords = unwrappedresults
                    print(self.winningWords)
                }
        }
        
            task.resume()
        
        one.setTitle(String(describing: pieces[0]), for: .normal)
        two.setTitle(String(describing: pieces[1]), for: .normal)
        three.setTitle(String(describing: pieces[2]), for: .normal)
        four.setTitle(String(describing: pieces[3]), for: .normal)
        five.setTitle(String(describing: pieces[4]), for: .normal)
        six.setTitle(String(describing: pieces[5]), for: .normal)
        seven.setTitle(String(describing: pieces[6]), for: .normal)
        eight.setTitle(String(describing: pieces[7]), for: .normal)
        nine.setTitle(String(describing: pieces[8]), for: .normal)
        ten.setTitle(String(describing: pieces[9]), for: .normal)
        eleven.setTitle(String(describing: pieces[10]), for: .normal)
        twelve.setTitle(String(describing: pieces[11]), for: .normal)
        thirteen.setTitle(String(describing: pieces[12]), for: .normal)
        fourteen.setTitle(String(describing: pieces[13]), for: .normal)
        fifteen.setTitle(String(describing: pieces[14]), for: .normal)
        sixteen.setTitle(String(describing: pieces[15]), for: .normal)

    
    }
    
    @IBAction func hitLetter(_ sender: UIButton) {
        
        pointsLabel.isHidden = true
        
        sender.isEnabled = false
        
        sender.backgroundColor = UIColor.yellow
        
        self.word.append((sender.titleLabel?.text)!)
        
        OperationQueue.main.addOperation {
            let words = self.word.joined(separator: " ")
            self.wordLabel.text = words
        }
        print("touched button")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func randoLetter()->String{
     
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T","U", "V", "W", "X", "Y", "Z"]
//        let letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        let randoindex = Int(arc4random_uniform(25))
        
        return letters[randoindex]
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        let singleword = word.joined(separator: "")
        
        if self.winningWords.contains(singleword){
            word.removeAll()
            self.pointsLabel.isHidden = false
            toggleButtons(button: nil)
            OperationQueue.main.addOperation {
                let words = self.word.joined(separator: " ")
                self.wordLabel.text = words
            }
        }
        
    }
    @IBAction func removeTapped(_ sender: UIButton) {
        
        var letter = ""
        
        if word.count > 0{
            letter = self.word.removeLast()
              }
            for viewer in self.holder.subviews{
                
                print("each view: \(viewer)")
//                if view.isMember(of: UIButton){
                    print("is a button")

                    let viewish = viewer as? UIButton
                    print("title: \(viewish?.titleLabel?.text)")
                
                    if viewish?.titleLabel?.text == letter{
                        print("viewish: \(viewish)")

                        toggleButtons(button: viewish)
//                    }
                    
              
                
            }
            OperationQueue.main.addOperation {
                let words = self.word.joined(separator: " ")
                self.wordLabel.text = words
            }
        }
    }
    
    func toggleButtons(button: UIButton?){
        
        if button == nil{
        one.isEnabled = true
        two.isEnabled = true
        three.isEnabled = true
        four.isEnabled = true
        seven.isEnabled = true
        eight.isEnabled = true
        five.isEnabled = true
        nine.isEnabled = true
        ten.isEnabled = true
        eleven.isEnabled = true
        twelve.isEnabled = true
        thirteen.isEnabled = true
        fifteen.isEnabled = true
        sixteen.isEnabled = true
        fourteen.isEnabled = true
        six.isEnabled = true
        }else{
            button?.isEnabled = true
        }

    }
}

