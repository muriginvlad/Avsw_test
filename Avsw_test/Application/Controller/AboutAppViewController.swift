//
//  AboutAppViewController.swift
//  Avsw_test
//
//  Created by Владислав on 19.10.2020.
//

import Foundation
import UIKit

class AboutAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
