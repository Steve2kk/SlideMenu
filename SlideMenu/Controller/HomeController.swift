
import UIKit
class HomeController: UITableViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItems()
    }
    
    fileprivate func setupNavItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "hide", style: .plain, target: self, action: #selector(handleHide))
    }

    @objc func handleOpen() {
        (UIApplication.shared.windows[0].rootViewController as? BaseController)?.openMenu()
    }
    
    @objc func handleHide() {
        
    }
    
    //MARK:- setupTableView
    fileprivate let cellId = "cellId"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = "row:\(indexPath.row)"
        return cell
    }
}

