//
//  ViewController.swift
//  ColeDeonslow_CE4Adaptive LayoutProject
//
//  Created by Deon Cole on 4/9/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import CoreData

//Declare a variable to allow the view controller to save data to core data.
var managedObjContext: NSManagedObjectContext!


class ViewController: UIViewController{
    
    //Declare a variable that will hold the users name
    var userNameTextField: UITextField?

    //Declare a variable to hold the timer function to activate the timer.
    var timer = NSTimer()
    
    //Declare arrays to be used to hold data for the types of images and a dictionary that will be used to  randomize the images.
    var imageArray: [String] = []
    var mainPics = [String]()
    
    //Declare arrays to hold the selected images and the index paths to be compared.
    var selectedPic = [UIView]()
    var selectedIndexs: [NSIndexPath] = []
    
    
    //Declare variables to hold the counter for the time
    var minutes = 0
    var seconds = 0
    
    //Declare boolean variables to be used for the collection view
    var isMatched = false
    
    //Declare a variable to hold the number of images and moves
    var imageCounter = 0
    var numberOfMoves = 0
    var timeFinished = ""
    var userName = ""
    
    //Set the date
    var date = ""
    let formatter = NSDateFormatter()
    var gameDate = ""
    
    //Declare a constant to be a Tap gesture recognizer so the user can tap on a view.
    var tapIt = UITapGestureRecognizer()
    
    //MARK: Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var mainView: UIView!
    
    
    @IBOutlet var imageCollection: [UIImageView]!
    
    
    @IBOutlet var imageHolderCollection: [UIView]!
    
    
    @IBOutlet weak var remainingLabel: UILabel!
    
    @IBOutlet weak var resultsView: UIView!
    
    @IBOutlet weak var timeResultLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
   
    //MARK: Core Data
    
//    //Declare a variable to allow the view controller to save data to core data.
//    var managedObjContext: NSManagedObjectContext!
    
    //Declare the description of the entity in the CoreData file
    var entityDescription: NSEntityDescription!
    
    //Declare a variable that will represent the entity type using NSManagedObject
    var thePlayer: NSManagedObject!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        
        date = formatter.stringFromDate(NSDate())
        
        
        
        //Loop through the collection of views that hold the images and style them.
        for container in imageHolderCollection {
            container.layer.cornerRadius = 10
            container.backgroundColor = UIColor.blackColor()
        }
        
        //Detect if the user's device is either a iPhone or iPad. After doing so use the correct array.
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            imageArray = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10"]
            print("It's a iPhone")
        case .Pad:
            imageArray = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15", "image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9", "image10", "image11", "image12", "image13", "image14", "image15"]
            print ("It's a iPad")
        default:
            print ("This isn't a real device")
        }

        
        //Set the user interaction for the entire view equal to false to that the user can't tap any of the cells until the play now button is clicked
        cardView.userInteractionEnabled = false
        
        cardView.multipleTouchEnabled = false
        
        //Set the counter equal to the count of the mainPics array
        imageCounter = imageArray.count
        
        //Fill out the entity description
        entityDescription = NSEntityDescription.entityForName("Player", inManagedObjectContext: managedObjContext)
        
        //Use the description to make a entity and save it to CoreData
        thePlayer = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: managedObjContext)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    //MARK: Functions
    
    //This method generates a random order of images
    func picGenerator () {
        //declare a empty array to hold ints
        var ranInts: [Int] = []
        //declare a variable to generate random numbers from 0 - 10
        var randomNumber = Int(arc4random_uniform(UInt32(11)))
        var aRandomNumber = Int(arc4random_uniform(UInt32(31)))
        
        
        //Use a switch statement to check if the device is a iPhone or iPad
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            //Use a while loop to run while the count of the ranInts array is less than 11. If the array doesn't contain the number add it to the array. If it does the number is just generated.
            while ranInts.count < 21 {
                if ranInts.contains(randomNumber) == false {
                    ranInts.append(randomNumber)
                } else {
                    randomNumber = Int(arc4random_uniform(UInt32(21)))
                }
            }
            
            //Use a while loop to run while the array to hold the random generated images count is less than 20. Iterate through the ranInts array then iterate through the imageArray and enumerate it. Use a conditional to check if the numbers from the ranInts array are equal to the index of the imageDictionary array. If they are append the images to the mainPics array to have a random order of pics.
            while mainPics.count < 20 {
                for ranNumbers in ranInts {
                    for thePics in imageArray.enumerate(){
                        if ranNumbers == thePics.index {
                            mainPics.append(thePics.element)
                        }
                    }
                }
            }
            
        default:
            while ranInts.count < 31 {
                if ranInts.contains(aRandomNumber) == false {
                    ranInts.append(aRandomNumber)
                } else {
                    aRandomNumber = Int(arc4random_uniform(UInt32(31)))
                }
            }
            
            while mainPics.count < 30 {
                for aRanNumbers in ranInts {
                    for thePics in imageArray.enumerate(){
                        if aRanNumbers == thePics.index {
                            mainPics.append(thePics.element)
                        }
                    }
                }
            }
        }
        
        //Loop through the array of image views. As long as the count of the random image array is more than 0 generate a random number of the random image array count and add a image to a image view removing it from the array. Once the loop reaches 0 it will stop as the array is empty.
        for holder in imageCollection {
            if mainPics.count > 0 {
                let aNum = Int(arc4random_uniform(UInt32(mainPics.count)))
                holder.image = UIImage(named: mainPics.removeAtIndex(aNum))
                holder.layer.cornerRadius = 10
                holder.backgroundColor = UIColor.whiteColor()
                holder.hidden = true
            }
        }
    }
    
    
    //This method covers the images chosen if the user is incorrect.
    func noMatch(){
        
        //Loop through the selected pics that the user chose. Typecast the subviews of the chosen views as Image views and hide them.
        for items in selectedPic {
            (items.subviews[0] as! UIImageView).hidden = true
        }
        
        //Count the number of moves the user makes
        numberOfMoves = numberOfMoves + 2
        print(numberOfMoves)
        
        //Remove the items that the user chose from the array so that new items can be selected
        selectedPic.removeAll()
        
        //User can go back to chsing a image
        cardView.userInteractionEnabled = true
    }
    
    
    
    //This method will be used to remove the images from the board. Loop through the selected images by the user and hide them. Empty the selectedPic array for the next chosen images.
    func gotMatch() {
        
        for items in selectedPic{
            items.hidden = true
        }
        
        //Remove two from the image counter to keep track of the number of remaining images on the board.
        imageCounter = imageCounter - 2
        
        //Display the remaining number of images
        remainingLabel.text = " Remaining: \(imageCounter)"
        
        //Count the number of moves the user has made
        numberOfMoves = numberOfMoves + 2
        print(numberOfMoves)
        
        //Enable ineraction so that the user can chose another image
        cardView.userInteractionEnabled = true
        
        //Clear out the selectedPic array for the user to pic two new images
        selectedPic.removeAll()
        
        //if the match counter equals to 0, stop the time. Alert the user that they have finished and the time they finished. Send the user to the next view to see their highlights from the game
        if imageCounter == 0 {
            timer.invalidate()
            
            timeFinished = timeLabel.text!
            
            let alert = UIAlertController(title: "Congratulations", message: "You made all of the Matches. \n Your winning time is \(timeLabel.text!) \n Enter your name!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let scoresButton = UIAlertAction(title: "See Scores", style: UIAlertActionStyle.Default, handler: { (action) in

                //Save the players info to the CoreData entity
                self.thePlayer.setValue((self.userNameTextField?.text)!, forKey: "playerName")
                self.thePlayer.setValue(self.numberOfMoves, forKey: "moves")
                self.thePlayer.setValue(self.timeFinished, forKey: "timePlayed")
                self.thePlayer.setValue(self.date, forKey: "datePlayed")
                (UIApplication.sharedApplication().delegate as! AppDelegate).CDStack.saveContext()
                
                
                //Load the new view controller with the updated info
                self.performSegueWithIdentifier("toHighlightController", sender: self)
                
            })
            
            alert.addAction(scoresButton)
            
            //Add a text field to the alert so that the user can enter their name. Give a default name in the text field of the users device. Set the name to the global user name variable to be used outside of the scope.
            alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
                    textField.text = UIDevice.currentDevice().name
                    self.userNameTextField = textField
            }
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    
    
    //This method is for when the cards are tapped
    func tappedCard(sender: UITapGestureRecognizer) {
        
        (sender.view?.subviews[0] as! UIImageView).hidden = false
        
        //Check to see if the user has selected more than 2 boxes by checking the count of the selectedPics array that holds what the user has chosen.
        if selectedPic.count > 0 {
            
            //Use the description of each of the chosen pic to make sure that the user has not picked the same image. If the two aren't the same append it them to the array. If the user choses the same image then cover it up using the no match function.
            if sender.view?.description != selectedPic[0].description {
                selectedPic.append(sender.view!)
            } else {
                
                noMatch()
            }
        }
            
        else {
            //If users choses two different images, no check is needed and append the two to the selectedPics array.
            selectedPic.append(sender.view!)
            (sender.view?.subviews[0] as! UIImageView).hidden = false
        }
        
        //Check the two selected images in the selectPic array to see if they are equal
        if selectedPic.count == 2 {
            
            //Use a if statement for if the selected views in the array typecasted as UIImages are equal. If they are run the gotMatch function.
            if (selectedPic[0].subviews[0] as! UIImageView).image == (selectedPic[1].subviews[0] as! UIImageView).image {
                
                //Disable interaction with the cards so that the user is not able to click and see any other images
                cardView.userInteractionEnabled = false
                
                //Use a NSTimer to allow the user to see the images that were selected and run the gotMatch function as a selector in order to make the images disappear.
                _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.gotMatch), userInfo: nil, repeats: false)
                
            }
            else {
                
                //If there is no match don't hide the images immediately.
                (sender.view?.subviews[0] as! UIImageView).hidden = false
                
                //Disable the interaction so that the user is not able to click and see any other images.
                cardView.userInteractionEnabled = false
                
                //Use a NSTimer to allow the user to see the images that were selected and run the noMatch function as a selector in order to cover them back up.
                _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.noMatch), userInfo: nil, repeats: false)
            }
        }
        
        
    }
    
    
    
    //MARK: Actions
    
    //This method controls the time interval and is called every second that passes. It is passed as a parameter to the selector to the timer in the playNowButton method.
    func startTime(){
        
        //When the method is called the second counter will be added by one. Use a if statement to check if the seconds equal 60 add one to the minutes counter and reset the seconds counter to 0.
        seconds += 1
        
        if seconds == 60 {
            
            minutes += 1
            seconds = 0
        }
        
        
        //Declare constants to hold the seconds and minutes that are calculated. The constants will hold/use a Ternary Conditional to create the text for the time. This is short hand form of a if statement that sets everything up. It "asks" if the designated time counter is greater than 9, if so then the constant will be a string between :10 - :59 else between :00 - :00.
        let minuteText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let secondText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        //Set the designated time label that holds the time text equal to the constants that hold the time.
        timeLabel.text = "\(minuteText) : \(secondText)"
        
        //Hide the view holding the button so the user can not tap the play now button again.
        bottomView.hidden = true
        
    }
    
    
    @IBAction func playNowButton(sender: AnyObject) {
        
        //Call the function that will randomize the images to be loaded
        picGenerator()
        
        //Set the timer function to the interval that will count every second, targeted to itself, with the selector set to the view controller startTime function as it's parameter, no userInfo and it will repeat.
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.startTime), userInfo: nil, repeats: true)
        
        //Allow user interaction with the cards now that the user can play.
        cardView.userInteractionEnabled = true
        
        cardView.multipleTouchEnabled = true
        
        //Add a tap gesture to each view holding the images in order to recognize what the user has tapped.
        for holder in imageHolderCollection{
            tapIt = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedCard))
            holder.addGestureRecognizer(tapIt)
        }
        
    }
    
    //Unwind from the hightlights and scores view controller
    @IBAction func unwindToRoot(segue: UIStoryboardSegue){
        cardView.hidden = false
        bottomView.hidden = false
        timeLabel.text = nil
        minutes = 0
        seconds = 0
        imageCounter = imageArray.count
        for holder in imageHolderCollection{
            holder.hidden = false
        }
        for image in imageCollection{
            image.hidden = true
        }
        remainingLabel.text = "Remaining: 30"
        userName = ""
        numberOfMoves = 0
        timeFinished = ""
        cardView.userInteractionEnabled = false
        
    }
    
}
    