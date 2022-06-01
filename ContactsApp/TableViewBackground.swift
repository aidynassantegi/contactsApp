//
//  TableViewBackground.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

class TableViewBackground: UIView {

    private let noContactsLabel: UILabel = {
        let label = UILabel()
        label.text = "No cantacts yet"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noContactsLabel)
        NSLayoutConstraint.activate([
            noContactsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noContactsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noContactsLabel.widthAnchor.constraint(equalToConstant: 200),
            noContactsLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
