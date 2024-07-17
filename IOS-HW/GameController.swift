//
//  ViewController.swift
//  IOS-HW
//
//  Created by Student11 on 26/06/2024.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var eastSideScore: UILabel!
    @IBOutlet weak var westSideScore: UILabel!
    @IBOutlet weak var eastSidePlayerName: UILabel!
    var userData: UserData!
    @IBOutlet weak var westSidePlayerName: UILabel!
    @IBOutlet weak var westSideCardImageView: UIImageView!
    @IBOutlet weak var eastSideCardImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    private let westCards = [#imageLiteral(resourceName: "1_of_clubs"), #imageLiteral(resourceName: "2_of_clubs"), #imageLiteral(resourceName: "3_of_clubs"), #imageLiteral(resourceName: "4_of_clubs"), #imageLiteral(resourceName: "5_of_clubs"), #imageLiteral(resourceName: "6_of_clubs"), #imageLiteral(resourceName: "7_of_clubs"), #imageLiteral(resourceName: "8_of_clubs"), #imageLiteral(resourceName: "9_of_clubs"), #imageLiteral(resourceName: "10_of_clubs"), #imageLiteral(resourceName: "11_of_clubs"), #imageLiteral(resourceName: "12_of_clubs"), #imageLiteral(resourceName: "13_of_clubs")]
    private let eastCards = [#imageLiteral(resourceName: "1_of_diamonds"), #imageLiteral(resourceName: "2_of_diamonds"), #imageLiteral(resourceName: "3_of_diamonds"), #imageLiteral(resourceName: "4_of_diamonds"), #imageLiteral(resourceName: "5_of_diamonds"), #imageLiteral(resourceName: "6_of_diamonds"), #imageLiteral(resourceName: "7_of_diamonds"), #imageLiteral(resourceName: "8_of_diamonds"), #imageLiteral(resourceName: "9_of_diamonds"), #imageLiteral(resourceName: "10_of_diamonds"), #imageLiteral(resourceName: "11_of_diamonds"), #imageLiteral(resourceName: "12_of_diamonds"), #imageLiteral(resourceName: "13_of_diamonds")]
    private let westCardFaceDown = #imageLiteral(resourceName: "black_back_card")
    private let eastCardFaceDown = #imageLiteral(resourceName: "red_back_card")
    
    private var userScore = 0
    private var pcScore = 0
    private var roundNumber = 0
    private var tick = 5
    private let numberOfRounds = 10

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setStartScreen()
        
        startGame()
    }
    
    func startGame(){

        timerTick(t: Timer())
    }
    
    func timerTick(t:Timer){
        setFaceDownCards()
        updateTimer(tick: tick)
        if tick > 0{
            tick -= 1
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: timerTick(t:))
        }
        else{
            tick = 5
            startRound(t: Timer())
        }
    }
    
    func updateTimer(tick: Int){
        timerLabel.text = "\(tick)"
    }
    
    func startRound(t: Timer){
        if roundNumber >= numberOfRounds{
            endGame()
        }
        handleCardSelected(westIndex: Int.random(in: 0..<13), eastIndex: Int.random(in: 0..<13))
        
        setScores()
        
        roundNumber += 1
        
        showCardsTimer()
                
    }
    
    func endGame(){
        // TODO create end game screen
        print("end")
    }
    
    func showCardsTimer(){
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: timerTick(t:))
    }

    
    func setScores(){
        if(userData.globeSide == GlobeSide.East){
            eastSideScore.text = "\(userScore)"
            westSideScore.text = "\(pcScore)"
        }else{
            eastSideScore.text = "\(pcScore)"
            westSideScore.text = "\(userScore)"
        }
    }
    
    func handleCardSelected(westIndex: Int, eastIndex:Int){
        setEastSideCard(index: eastIndex)
        setWestSideCard(index: westIndex)
        
        if userData.globeSide == GlobeSide.East{
            determineRoundWinner(userIndex: eastIndex, pcIndex: westIndex)
        }else{
            determineRoundWinner(userIndex: westIndex, pcIndex: eastIndex)
        }
    }
    
    func determineRoundWinner(userIndex: Int, pcIndex: Int){
        if pcIndex > userIndex {
            pcScore += 1
        }else if pcIndex < userIndex {
            userScore += 1
        }
    }
    
    func setStartScreen(){
        setFaceDownCards()
        switch userData.globeSide{
        case GlobeSide.East:
            eastSidePlayerName.text = userData.userName
            westSidePlayerName.text = "PC"
            eastSideScore.text = "\(userScore)"
            westSideScore.text = "\(pcScore)"
            
        case GlobeSide.West:
            eastSidePlayerName.text = "PC"
            westSidePlayerName.text = userData.userName
            eastSideScore.text = "\(userScore)"
            westSideScore.text = "\(pcScore)"
            
        }
        
    }
    
    func setWestSideCard(index: Int){
        // here assuming index withing range
        westSideCardImageView.image = westCards[index]
        westSideCardImageView.contentMode = .scaleAspectFit
    }
    
    func setEastSideCard(index: Int){
        // here assuming index withing range
        eastSideCardImageView.image = eastCards[index]
        eastSideCardImageView.contentMode = .scaleAspectFit
    }
    
    func setFaceDownCards(){
        eastSideCardImageView.image = eastCardFaceDown
        westSideCardImageView.image = westCardFaceDown
        eastSideCardImageView.contentMode = .scaleAspectFill
        westSideCardImageView.contentMode = .scaleAspectFill
        
    }


}

