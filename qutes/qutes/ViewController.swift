//
//  ViewController.swift
//  qutes
//
//  Created by student2 on 8/25/16.
//  Copyright © 2016 DmytroRyshchuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var quoteTextView: UITextView!
    
    var randomNumber = 0
    var authorArray = [String]()
    var quotesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func randomQuote(sender: AnyObject) {
        let random = arc4random_uniform(UInt32(quotesArray.count))
        randomNumber = Int(random)
        
        authorNameLabel.text! = authorArray[randomNumber]
        quoteTextView.text! = quotesArray[randomNumber]
    }
    
    func parse() {
        let url = NSBundle.mainBundle().URLForResource("data", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            
                if let text = json["text"] as? [[String: AnyObject]] {
                    
                    for textes in text {
                    
                    if let quotes = textes["quotes"] as? [String: AnyObject] {
                        if let author = quotes["author"] as? String {
                            authorArray.append(author)
                        }
                        if let quote = quotes["quote"] as? String {
                            quotesArray.append(quote)
                        }
                    }
            }
                    let random = arc4random_uniform(UInt32(quotesArray.count))
                    randomNumber = Int(random)
                    
                    authorNameLabel.text! = authorArray[randomNumber]
                    quoteTextView.text! = quotesArray[randomNumber]
            }
        } catch {
                print("error")
            }
        }
    }


