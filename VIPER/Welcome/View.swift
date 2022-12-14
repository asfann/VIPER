//
//  View.swift
//  VIPER
//
//  Created by Asf on 10.12.2022.
//

import Foundation
import UIKit


protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with users: [User])
    func update(with error: String)
}


class UserViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    var presenter: AnyPresenter?
    
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    
    func update(with users: [User]) {
        print("got users ")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
        
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.text = error
            self.label.isHidden = false
            self.tableView.isHidden = true
        }
    }
    
    
    
    
    // number
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
}
