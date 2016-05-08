//
//  SecondViewController.swift
//  ColeDeonslow_CE4Adaptive LayoutProject
//
//  Created by Deon Cole on 4/27/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import CoreData


class SecondViewController: UIViewController {
    
    //Create outlets
    @IBOutlet weak var firstPlaceLabel: UILabel!
    @IBOutlet weak var secondPlaceLabel: UILabel!
    @IBOutlet weak var thirdPLaceLabel: UILabel!
    @IBOutlet weak var fourthPlaceLabel: UILabel!
    @IBOutlet weak var fifthPlaceLabel: UILabel!
    
    
    //Declare variable for empty string
    var gameInfo = ""
  
    
    //Request the entity from the data model
    let fetchRequest = NSFetchRequest(entityName: "Player")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Declare a variable to be a NSSortDescriptor that will sort the entity by the assigned attribute. Set ascending to true. Do the fetch request and loop through the entity setting values for each attribute. Use a if statement to set the values of the 1st through 5th place labels to display to the user.
        let sortDescriptor = NSSortDescriptor(key: "timePlayed", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            let results = try managedObjContext.executeFetchRequest(fetchRequest)
            
            for result in results {
                
                if let userName = result.valueForKey("playerName"),
                    numberOfMoves = result.valueForKey("moves"),
                    timeFinished = result.valueForKey("timePlayed"),
                    gameDate = result.valueForKey("datePlayed"){
                    
                    print(userName, timeFinished, "\(numberOfMoves)", gameDate)
                    
                    if firstPlaceLabel.text == "" {
                        firstPlaceLabel.text =  "\(userName) finished with a time of \(timeFinished) in \(numberOfMoves) moves on \(gameDate)"
                    } else if secondPlaceLabel.text == "" {
                        secondPlaceLabel.text = "\(userName) finished with a time of \(timeFinished) in \(numberOfMoves) moves on \(gameDate)"
                    } else if thirdPLaceLabel.text == "" {
                        thirdPLaceLabel.text = "\(userName) finished with a time of \(timeFinished) in \(numberOfMoves) moves on \(gameDate)"
                    } else if fourthPlaceLabel.text == "" {
                        fourthPlaceLabel.text = "\(userName) finished with a time of \(timeFinished) in \(numberOfMoves) moves on \(gameDate)"
                    } else if fifthPlaceLabel.text == "" {
                        fifthPlaceLabel.text = "\(userName) finished with a time of \(timeFinished) in \(numberOfMoves) moves on \(gameDate)"
                    } else {
                        break
                    }
                }
            }
        }
        catch {
            print("Load Failed")
        }
        
        
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
