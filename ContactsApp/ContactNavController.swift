//
//  ContactNavController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

class ContactNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let rootVC = ViewController()
//        let navVC = UINavigationController(rootViewController: rootVC)
//        present(navVC, animated: false)
        self.pushViewController(ViewController(), animated: false)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
