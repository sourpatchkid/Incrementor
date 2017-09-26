//
//  ViewController.swift
//  Incrementor
//
//  Created by Wyatt Allen on 9/19/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    
    // main
    @IBAction func stepper(_ sender: UIStepper) {
        // current count
        let count: Int = Int(sender.value)
        
        // max value of the stepper
        let maxLimit: Int = Int(sender.maximumValue)
        // min value ...
        let minLimit: Int = Int(sender.minimumValue)
        
        // boolean value of "isMax" in the returned tuple of "reachLimit"
        let isCountMax: Bool = ((reachLimit(currentValue: count, maxValue: maxLimit, minValue: minLimit))?.isMax)!
        // boolean value of "isMax" ...
        let isCountMin: Bool = ((reachLimit(currentValue: count, maxValue: maxLimit, minValue: minLimit))?.isMin)!
        
        // boolean value of "isPrime" return value
        let isCountPrime: Bool = isPrime(currentValue: count)
        
        // sad emoji face
        let emojiStart: String = "\u{1F641}"
        
        // the number of the possible values of the stepper
        let countRange: Int = abs(maxLimit - minLimit)
        
        // how far the current count is from the bottom, relavent to progressBar
        let distanceFromLowerBound: Int = abs(count - minLimit)
        
        
        
        /*
         Update/Initialize values
         */
        
        countLabel.text = "\(count)"
        progressBar.progress = Float(distanceFromLowerBound)/Float(countRange)
        // emojiLabel will start as sad emoji and get progressively happier
        emojiLabel.text = emojiStart
        congratsLabel.text = congratulator(isMax: isCountMax, isMin: isCountMin, isPrime: isCountPrime).congratsString
        emojiLabel.text = congratulator(isMax: isCountMax, isMin: isCountMin, isPrime: isCountPrime).congratsEmoji
        
        
        //           print("isMax is: " + "\(isCountMax)" + " on count: " + "\(count)")
        //        print("isMin is: " + "\(isCountMin)" + " on count: " + "\(count)")
        
        
    }
    
    
    
    
    // Takes current value and limit values (where Max != Min) and returns a tuple containing whether the current value is a Max, Min, or Neither
    func reachLimit(currentValue: Int, maxValue: Int, minValue: Int) -> (isMax: Bool, isMin: Bool)? {
        
        // isMax
        if currentValue == maxValue && currentValue != minValue {
            //            print("Yay! isMax is working")
            return (isMax: true, isMin: false)
        }
        
        // isMin
        if currentValue == minValue && currentValue != maxValue {
            //            print("Yay! isMin is working")
            return (isMax: false, isMin: true)
        }
        
        // is both Max and Min edge-case
        if currentValue == maxValue && currentValue == minValue {
            return nil
        }
            // is not a limit value
        else {
            return (isMax: false, isMin: false)
        }
    }
    
    // Is the current value a prime number?
    func isPrime(currentValue: Int) -> Bool {
        if currentValue <= 1 {
            return false
        }
        if currentValue <= 3 {
            return true
        }
        var i = 2
        while i*i <= currentValue {
            if currentValue % i == 0 {
                return false
            }
            i = i + 1
        }
        return true
        
    }
    
    // Returns a congratulatory string and accompanying emoji in a tuple based upon which special cases are true
    func congratulator(isMax: Bool, isMin: Bool, isPrime: Bool) -> (congratsString: String, congratsEmoji: String) {
        
        var localCongratsString: String = "Congratulations you found "
        var localCongratsEmoji: String = ""
        let maxCongrats: String = "the maximum value"
        let minCongrats: String = "the minimum value"
        let primeCongrats: String = "a prime number"
        var wasLimitFound: Bool = false
        // No smile emoji
        let emojiRegular: String = "\u{1F610}"
        // Slight smile emoji
        let emojiSmile: String = "\u{1F642}"
        // Big grin emoji
        let emojiEcstatic: String = "\u{1F601}"
        
        
        if (isMax == true){
            wasLimitFound = true
            localCongratsString = localCongratsString + maxCongrats
            localCongratsEmoji = emojiSmile
        }
        else if (isMin == true){
            wasLimitFound = true
            localCongratsString = localCongratsString + minCongrats
            localCongratsEmoji = emojiSmile
        }
        
        if (isPrime == true){
            if(wasLimitFound == true){
                localCongratsString = localCongratsString + " and " + primeCongrats + "!!!"
                localCongratsEmoji = emojiEcstatic
            } else{
                // case where both isPrime and isMax is true
                localCongratsString = localCongratsString + primeCongrats
                localCongratsEmoji = emojiSmile
            }
        }
        // non-special numbers are just empty strings
        if (isMax == false && isMin == false && isPrime == false){
            localCongratsString = ""
            localCongratsEmoji = emojiRegular
        } else {
            // finish off special cases with an accompanying exclamation point
            localCongratsString = localCongratsString + "!"
            
        }
        
        return (congratsString: localCongratsString, congratsEmoji: localCongratsEmoji)
    }
}

