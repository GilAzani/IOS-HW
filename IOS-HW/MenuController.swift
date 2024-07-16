//
//  MenuController.swift
//  IOS-HW
//
//  Created by Student11 on 16/07/2024.
//

import UIKit
import CoreLocation

class MenuController: UIViewController{
    @IBOutlet weak var enterNameTitle: UILabel!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var enterNameButton: UIButton!
    @IBOutlet weak var globeFirstLine: UILabel!
    @IBOutlet weak var westOrEastLabel: UILabel!
    @IBOutlet weak var globeLastLine: UILabel!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    private var isSetName = false
    private var isSetLocation = false
    private let middlePosition = 34.817549168324334
    
    private var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUi()
        
        setUpLocationManagerAndGetLocation()
    }
    
    func setUpLocationManagerAndGetLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationRetrived(longitude: Double){
        if longitude > middlePosition{
            westOrEastLabel.text = "East"
        }else{
            westOrEastLabel.text = "West"
        }
        westOrEastLabel.isHidden = false
        globeFirstLine.isHidden = false
        globeLastLine.isHidden = false
        isSetLocation = true
        checkStartConditions()
    }
    
    func setUpUi(){
        globeFirstLine.isHidden = true
        globeLastLine.isHidden = true
        westOrEastLabel.isHidden = true
        startGameButton.isHidden = true
    }
    
    func nameEntered(name: String){
        isSetName = true
        enterNameTitle.text = "Hi \(name)!"
        enterNameTextField.isHidden = true
        enterNameButton.isHidden = true
        checkStartConditions()
    }
    
    func checkStartConditions(){
        if isSetName && isSetLocation {
            startGameButton.isHidden = false
        }
    }

    @IBAction func enterNameClicked(_ sender: Any) {
        let name = enterNameTextField.text!
        if name.count > 1 {
            nameEntered(name:name)
        }
    }
    @IBAction func startGameClicked(_ sender: Any) {
    }
    
}

extension MenuController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lon = location.coordinate.longitude
            locationRetrived(longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error location=\(error)")
    }
}
