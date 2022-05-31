//
//  ViewController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

class ViewController: UIViewController, DeleteContact {
    
    func deleteContactBy(number: Int) {
        contacts?.remove(at: number)
        Contact.numberOfContact -= 1
        tableView.reloadData()
    }
    

    private var contacts: [Contact]? {
        didSet {
            tableView.reloadData()
            if contacts?.count == 0 {
                tableView.backgroundView = TableViewBackground()
            }else {
                tableView.backgroundView = UIView()
            }
        }
    }
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = TableViewBackground()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    @objc private func addContact() {
//        if contacts == nil {
//            contacts = []
//        }
//
//        contacts?.append(Contact(name: "Monica", surname: "Bing", phoneNumber: "87770001122"))
        
        let vc = AddViewController()
        vc.adder = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as! TableViewCell
        if contacts?.count != 0 {
            if let contacts = contacts {
                cell.setContactData(contact: contacts[indexPath.item])
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.setContact(contact: contacts![indexPath.row])
        vc.remover = self
        vc.contactId = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            contacts?.remove(at: indexPath.row)
            Contact.numberOfContact -= 1
            tableView.reloadData()
        }
    }
    
}

extension ViewController: AddContact {
    func addNewContact(contact: Contact) {
        if contacts != nil {
            contacts?.append(contact)
        }else {
            contacts = [contact]
        }
    }
}

//MARK: - Setup and Set Constraints
extension ViewController {
    private func setupView() {
        view.backgroundColor = .white
        title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addContact))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 26.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue],
        for: .normal)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        view.addSubview(tableView)
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
