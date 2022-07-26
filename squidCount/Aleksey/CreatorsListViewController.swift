//
//  CreatorsListViewController.swift
//  squidCount
//
//  Created by Алексей on 26.07.2022.
//

import UIKit

class CreatorsListViewController: UITableViewController {
    
    private let creators = Creator.getEmployeDetails()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        creators.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "creator") as? CustomTableViewCell
        let creator = creators[indexPath.row]
        
        cell?.avatarImage.image = UIImage(named: "Алексей")
        cell?.nameLabel.text = creator.name
        cell?.positionLabel.text = creator.position
        cell?.avatarImage.layer.cornerRadius = (cell?.avatarImage.frame.size.height)! / 2
        
        return cell!
    }
}