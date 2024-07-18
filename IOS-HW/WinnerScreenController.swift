//
//  WinnerScreenController.swift
//  IOS-HW
//
//  Created by Student11 on 18/07/2024.
//

import UIKit

class WinnerScreenController: UIViewController{
    
    @IBOutlet weak var winnerScoreLabel: UILabel!
    @IBOutlet weak var winnerNameLabel: UILabel!
    
    var userDetails: UserData!
    var winnerScore: Int!
    var winnerName: String!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setUpWinnerUi()
        
    }
    
    func setUpWinnerUi(){
        winnerNameLabel.text = userDetails.userName
        winnerScoreLabel.text = "\(winnerScore ?? 0)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMainMenu"{
            let menuController = segue.destination as! MenuController
            menuController.userName = userDetails.userName
            menuController.isSetName = true
        }
    }
}


