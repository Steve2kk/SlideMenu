//
//  MomentsController.swift
//  SlideMenu
//
//  Created by Vsevolod Shelaiev on 28.11.2020.
//

import UIKit

class MomentsController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        view.backgroundColor = .white
        label.text = "Moments"
        label.font = UIFont.systemFont(ofSize: 30,weight: .bold)
        label.frame = view.frame
        label.textAlignment = .center
        navigationItem.title = "Moments"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(label)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Moment:\(indexPath.row)"
        return cell
    }
    
}
