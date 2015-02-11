//
//  FirstViewController.swift
//  Udemy9 To Do List
//
//  Created by Pei Sun on 2014-12-26.
//  Copyright (c) 2014 psun. All rights reserved.
//
//  A to do list that allows you to add and delete items from a table.
//  Items are stored into permanent storage with each modification.

import UIKit

var toDoItems:[String] = []
    //NOTE: This var available to the secondViewController since it's outside the FirstViewController class

class FirstViewController: UIViewController, UITableViewDelegate{
    
    //NOTE: For some reason, setting the constraints of the TableView to -16 Left and 0 Right makes the lines equidistant from the sides
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Displays the table using the array toDoItems
        
        //NOTE: func tableView does run code inside if array toDoItems is empty (i.e. when user first opens the app, whether or something has been stored). 
            //Therefore, we cannnot load from storedToDoItems from here. We can either load it in 
            //(1)      viewDidload at the first load of the app (used here)
            //(2)      or we can load is everytime the page is refreshed in viewWillAppear
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel.text = toDoItems[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedToDoItems: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoList"){
            
            //loads tempoarary toDoItems array from permanent storage
            
            toDoItems = []
            toDoItems = storedToDoItems as [String]
            
            /*  //Could also do this, but the line above is less likely to crash
            for var i = 0; i < storedToDoItems.count; ++i {
                toDoItems.append(storedToDoItems[i] as NSString)
            } */
            
            //if storedToDoItems is empty (i.e. the first time user opens the app), then don't do anything with storedToDoItems. Though it doesn't seem to crash without the 'if', doing things with 'nil' are prone to crashes
            //NOTE: We cannot do   toDoItems = storedToDoItems   b/c toDoItems is an array, storedToDoItems is an object
            //NOTE: remove the "?" after AnyObject? suggested in the fit-it

        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        //If user tries to delete an item from a table, update toDoItems array and save into permanent storage
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            toDoItems.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(toDoItems, forKey: "toDoList")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            tasksTable.reloadData() //Refreshes the table. Uses the @IBOutlet tasksTable below
            
        }
    }
    
    //Manually type the line below (or just right-click + control) If you type it, don't forget to right click the table on main storyboard and assign 'referencing outlets' to the outlet tasksTable 
    @IBOutlet var tasksTable: UITableView!
    
    //-------- optional code for learning ---------

    //If you want to refresh the table (or run a function) everytime the table is loaded, make IBOutlet var tasksTable & override func viewWillAppear
    //Q: What is the difference beween load and appear?
    //A: Loading happens just once when the app is first run. Appear is everytime the page is refreshed
    override func viewWillAppear(animated: Bool) {
        println("Running viewWillAppear")
    }
    //----------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

