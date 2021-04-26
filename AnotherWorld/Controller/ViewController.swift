//
//  ViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 25/04/2021.
//

import UIKit
class ViewController: UIViewController {

    
    @IBOutlet weak var SignInLabel: UILabel!
    @IBOutlet weak var username: IconTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fontConfig()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func fontConfig() -> Void {
        SignInLabel.font = UIFont(name: "Sora-SemiBold", size: 30.0)
    }


}

