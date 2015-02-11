//
//  SecondViewController.swift
//  Udemy9 To Do List
//
//  Created by Pei Sun on 2014-12-26.
//  Copyright (c) 2014 psun. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var getText: UITextField!
    
    
    // "Add" button
    @IBAction func buttonPressed(sender: AnyObject) {
        toDoItems.append(getText.text)
        NSUserDefaults.standardUserDefaults().setObject(toDoItems, forKey: "toDoList")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.view.endEditing(true)
    }
    
    //Allow return key to resign keyboard. Remember to delegate the text field "getText" to the view controller
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        getText.resignFirstResponder()
        return true
    }
    
    //can just start typing "touchesBegan" and it'll auto add the override code
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

