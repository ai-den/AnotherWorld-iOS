//
//  SignUpViewController.swift
//  AnotherWorld
//
//  Created by Aiden on 26/04/2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 24
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func gotoSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

