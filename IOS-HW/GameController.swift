//
//  ViewController.swift
//  IOS-HW
//
//  Created by Student11 on 26/06/2024.
//

import UIKit

class GameController: UIViewController {
    
    var userData: UserData?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(userData?.globeSide)
    }


}

