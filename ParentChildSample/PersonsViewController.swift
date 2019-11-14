//
//  PersonsViewController.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

extension UIView {
    func fillIn(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

private let cellID = "cell"

class PersonsViewController: UIViewController {

    lazy var generator: RandomPersonGenerator = {
        let update: ()->Void = {
            print("did update")
            self.tableView.reloadData()
        }
        let gen = RandomPersonGenerator(updateInterval: 3.0,
                                        makeInterval: 1.0,
                                        update: update)
        return gen
    }()
    
    lazy var tableView: UITableView = {
       let t = UITableView(frame: .zero, style: .plain)
        t.backgroundColor = .white
        t.register(UITableViewCell.self,
                   forCellReuseIdentifier: cellID)
        t.dataSource = self
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.fillIn(view)
        generator.start()
    }

}

extension PersonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generator.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = generator.persons[indexPath.row].description
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}
