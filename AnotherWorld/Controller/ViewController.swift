//
//  ViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 25/04/2021.
//

import UIKit
class ViewController: UIViewController {

    
    @IBOutlet weak var SignInLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    func fontConfig() -> Void {
        SignInLabel.font = UIFont(name: "Sora-SemiBold", size: 30.0)
        username.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 28, height: 28))
        username.leftViewMode = .always
        print("Font Configuration has done for Sign in VC.")
    }


}

