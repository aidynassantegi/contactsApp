//
//  TableViewCell.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let cellId = "cellId"
    
    private let contactImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContactData(contact: Contact) {
        nameLabel.text = contact.name
        contactNumber.text = contact.phoneNumber
        contactImageView.image = UIImage(named: contact.contactImagePath)
    }
    
}

extension TableViewCell {
    private func setupView() {
        addSubview(contactImageView)
        addSubview(nameLabel)
        addSubview(contactNumber)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: topAnchor),
            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contactImageView.heightAnchor.constraint(equalToConstant: 150),
            contactImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            contactNumber.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactNumber.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            contactNumber.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            contactNumber.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
