//
//  ViewController.swift
//  ContactsApp
//
//  Created by Aidyn Assan on 31.05.2022.
//

import UIKit

class MainViewController: UIViewController {
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
        let vc = AddViewController()
        vc.adder = self
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - Table View Update methods
extension MainViewController: AddContact , ContactsUpdater {
    func deleteContactBy(number: Int) {
        contacts?.remove(at: number)
        Contact.numberOfContact -= 1
    }
    
    func updateTableView(number: Int, newName: String, newNumber: String) {
        contacts?[number].name = newName
        contacts?[number].phoneNumber = newNumber
    }
    
    func addNewContact(contact: Contact) {
        if contacts != nil {
            contacts?.append(contact)
        }else {
            contacts = [contact]
        }
    }
}

//MARK: - Table View Delegates
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
        vc.contactsUpdater = self
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

//MARK: - Setup and Set Constraints
extension MainViewController {
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
