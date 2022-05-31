//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

protocol DeleteContact {
    func deleteContactBy(number: Int) -> Void
}

class DetailViewController: UIViewController {

    var remover: DeleteContact?
    
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
    
    private let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Call", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(callButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func callButtonPressed() {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        present(vc, animated: true)
    }
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var contactId = 0
    @objc private func deleteButtonPressed() {
        remover?.deleteContactBy(number: contactId)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        
    }
    
    func setContact(contact: Contact) {
        contactImageView.image = UIImage(named: contact.contactImagePath)
        nameLabel.text = contact.name
        contactNumber.text = contact.phoneNumber
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(contactImageView)
        view.addSubview(nameLabel)
        view.addSubview(contactNumber)
        view.addSubview(callButton)
        view.addSubview(deleteButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contactImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactImageView.heightAnchor.constraint(equalToConstant: 150),
            contactImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            contactNumber.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactNumber.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            contactNumber.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            contactNumber.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            callButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            callButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
