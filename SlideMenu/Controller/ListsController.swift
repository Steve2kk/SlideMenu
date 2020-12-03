
import UIKit

class ListsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.systemFont(ofSize: 30,weight: .bold)
        label.frame = view.frame
        label.textAlignment = .center
        view.addSubview(label)
    }
    
}
