//
//  AddViewController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

protocol AddContact {
    func addNewContact(contact: Contact) -> Void
}

class AddViewController: UIViewController {
    
    var adder: AddContact?
    private var genders = ["Female", "Male"]
    private var isMan = false
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Full name"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Contact number"
        textField.textAlignment = .center
        textField.keyboardType = .namePhonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc private func saveButtonPressed() {
        let imageBSet = ["b1", "b2", "b3"]
        let imageGSet = ["g1", "g2", "g3"]
        let indexOfImage = Contact.numberOfContact % 3
        Contact.numberOfContact += 1
        var contactImage: String
        if isMan {
            contactImage = imageBSet[indexOfImage]
        }else {
            contactImage = imageGSet[indexOfImage]
        }
        if let name = nameTextField.text, let contactNum = numberTextField.text {
            adder?.addNewContact(contact: Contact(name: name, phoneNumber: contactNum, contactImagePath: contactImage) )
            navigationController?.popViewController(animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    
    
    private func setupView() {
        title = "New contact"
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        view.addSubview(numberTextField)
        view.addSubview(saveButton)
        view.addSubview(pickerView)
        pickerView.delegate = self
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            numberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Picker View Delegates
extension AddViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 1 {
            isMan.toggle()
        }else {
            isMan = false
        }
    }
    
}
