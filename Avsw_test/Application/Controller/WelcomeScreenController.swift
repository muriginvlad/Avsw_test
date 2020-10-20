//
//  WelcomeScreenController.swift
//  Avsw_test
//
//  Created by Владислав on 15.10.2020.
//

import UIKit

class WelcomeScreenController: UIViewController {
    
    let login = "test"
    let password = "test"
    var label = "Добро пожаловать"
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginFiled: UITextField!
    @IBOutlet weak var passwordFiled: UITextField!
    
    
    @IBOutlet weak var horizontalBar: CustomProgressBar!
    
    var countdown : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterButton(_ sender: Any) {
        checkData()
    }
    
    func checkData(){
        
        if loginFiled.text == login && passwordFiled.text == password{
            for i in 1...100 {
                let progress = CGFloat(i / 100)
                horizontalBar.progress = progress
            }
            welcomeLabel.text = "Данные введены верно"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                self.performSegue(withIdentifier:"nextWelcome", sender: nil)
                
                            let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
                            modalViewController?.modalPresentationStyle = .fullScreen
                            if let vc = modalViewController {
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
            })
            
  // добавить переход
            
        } else {
            welcomeLabel.text = "Данные введены неверно "
        }
    }
}

