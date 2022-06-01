//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

protocol ContactsUpdater {
    func deleteContactBy(number: Int) -> Void
    func updateTableView(number: Int, newName: String, newNumber: String) -> Void
}

class DetailViewController: UIViewController {

    var contactsUpdater: ContactsUpdater?
    var contactId = 0
    
    
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
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contactTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    @objc private func deleteButtonPressed() {
        contactsUpdater?.deleteContactBy(number: contactId)
        navigationController?.popViewController(animated: true)
    }
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc private func updateButtonPressed() {
        contactsUpdater?.updateTableView(number: contactId,
                                         newName: nameTextField.text ?? "",
                                         newNumber: contactTextField.text ?? "" )
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
        nameTextField.text = contact.name
        contactNumber.text = contact.phoneNumber
        contactTextField.text = contact.phoneNumber
    }
    
    @objc private func editContact() {
        nameLabel.isHidden = true
        contactNumber.isHidden = true
        callButton.isHidden = true
        deleteButton.isHidden = true
        nameTextField.isHidden = false
        contactTextField.isHidden = false
        updateButton.isHidden = false
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editContact))
        view.backgroundColor = .white
        view.addSubview(contactImageView)
        view.addSubview(nameLabel)
        view.addSubview(contactNumber)
        view.addSubview(callButton)
        view.addSubview(deleteButton)
        view.addSubview(nameTextField)
        view.addSubview(contactTextField)
        view.addSubview(updateButton)
        nameTextField.isHidden = true
        contactTextField.isHidden = true
        updateButton.isHidden = true
        
        
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
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            contactNumber.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactNumber.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            contactNumber.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            contactNumber.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            contactTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            contactTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            contactTextField.heightAnchor.constraint(equalToConstant: 50)
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
        
        NSLayoutConstraint.activate([
            updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
