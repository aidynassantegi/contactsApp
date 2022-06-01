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
        self.pushViewController(MainViewController(), animated: false)
    }

}
