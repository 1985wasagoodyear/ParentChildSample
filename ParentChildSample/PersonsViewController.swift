//
//  PersonsViewController.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

private let cellID = "cell"

class PersonsViewController: UIViewController {

    // MARK: - Properties
    
    lazy var generator: RandomPersonGenerator = {
        let update: ()->Void = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.peopleCountLabel.text = "There are \(self.generator.persons.count) people"
                self.tableView.reloadData()
            }
        }
        let generator = RandomPersonGenerator(updateInterval: 0.75,
                                              makeInterval: 0.3,
                                              update: update)
        generator.useCorrectMethod = true
        return generator
    }()
    
    // MARK: - Storyboard Outlets
    
    @IBOutlet var peopleCountLabel: UILabel!
    @IBOutlet var makePeopleOptionsSegmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var makePeopleButton: UIButton!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                   forCellReuseIdentifier: cellID)
        tableView.dataSource = self
    }
    
    // MARK: - Custom Action Methods
    
    @IBAction func makePeopleOptionsAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            generator.useCorrectMethod = true
        default:
            /// will eventually cause a crash, at some unspecific time in the future.
            generator.useCorrectMethod = false
        }
    }
    
    @IBAction func makePeopleButtonAction(_ sender: UIButton) {
        if generator.isMakingPeople {
            generator.stop()
            sender.setTitle("Start", for: .normal)
            showFadingAlert(text: "Stopped making people!")
        } else {
            generator.start()
            sender.setTitle("Stop", for: .normal)
            showFadingAlert(text: "Started making people!")
        }
    }
    
    func showFadingAlert(text: String) {
        let alert = UIAlertController(title: text,
                                      message: nil,
                                      preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                alert.dismiss(animated: true)
            }
        }
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
