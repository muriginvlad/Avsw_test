//
//  MenuViewController.swift
//  Avsw_test
//
//  Created by Владислав on 16.10.2020.
//

import Foundation
import UIKit



class MenuViewController: UIViewController, UITableViewDelegate {
    
  @IBOutlet weak var tableView: UITableView!
    let applicationsMenu = ["Редактирование", "Просмотр","О программе"]
 

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.backgroundColor = UIColor.black
  }
}

extension MenuViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return applicationsMenu.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell" , for: indexPath) as! MenuCell
    cell.menuItemLabel.text = applicationsMenu[indexPath.row]
    cell.backgroundColor = UIColor.clear
    return cell
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
            modalViewController?.modalPresentationStyle = .fullScreen
            if let vc = modalViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.row == 1 {
            
            let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "ObjectView")
            modalViewController?.modalPresentationStyle = .fullScreen
            if let vc = modalViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            
            
        } else if indexPath.row == 2 {
            
            let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutAppViewController")
            modalViewController?.modalPresentationStyle = .fullScreen
            if let vc = modalViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        hideMenu()
    }
}

extension MenuViewController {
    
    func hideMenu(){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
    
}



