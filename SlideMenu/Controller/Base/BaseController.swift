
import UIKit

class BaseController: UIViewController {
    // closures->
    let redView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
        setupPanGesture()
    }
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapDismiss(gesture: UITapGestureRecognizer) {
        closeMenu()
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var translationX = translation.x
        
        translationX = isMenuOpened ? translationX + widthMenu : translationX
        translationX = min(widthMenu,translationX)
        translationX = max(0,translationX)
        
        redViewleadingConstraint.constant = translationX
        redViewTrailingConstraint.constant = translationX
        darkCoverView.alpha = translationX / widthMenu
        
        if gesture.state == .ended {
            gestureEnded(gesture: gesture)
        }
    }
    
    fileprivate func gestureEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityToSlideMenu {
                closeMenu()
                return
            }
            if abs(translation.x) < widthMenu / 2 {
                openMenu()
            }else {
                closeMenu()
            }
        }else {
            if abs(velocity.x) > velocityToSlideMenu {
                openMenu()
                return
            }
            if translation.x < widthMenu / 2 {
                closeMenu()
            }else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpened = true
        redViewleadingConstraint.constant = widthMenu
        redViewTrailingConstraint.constant = widthMenu
        performAnimation()
    }
    
    func closeMenu() {
        redViewleadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimation()
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performViewCleanUp()
        closeMenu()
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListsController())
        case 2:
            rightViewController = UINavigationController(rootViewController: BookmarksController())
        default:
            let tabBarController = UITabBarController()
            let navController = UINavigationController(rootViewController: MomentsController())
            navController.tabBarItem.title = "Moments"
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        }
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(darkCoverView)
        
    }
    
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    //let slideMenuController = CategoriesController()
    
    fileprivate func performViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        }
    }
    
    var redViewleadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    var blueViewTrailingAnchor: NSLayoutConstraint!
    
    fileprivate let widthMenu:CGFloat = 270
    fileprivate var isMenuOpened = false
    fileprivate let velocityToSlideMenu: CGFloat = 500
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        redView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        redViewleadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        redViewleadingConstraint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        
        blueView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blueViewTrailingAnchor = blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor)
        blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        blueView.widthAnchor.constraint(equalToConstant: widthMenu).isActive = true
        blueViewTrailingAnchor.isActive = true
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers(){
        let slideMenuController = SlideMenuController()
        
        let slideMenuView = slideMenuController.view!
        let homeView = rightViewController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        slideMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(slideMenuView)
        
        homeView.topAnchor.constraint(equalTo: redView.topAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor).isActive = true
        
        slideMenuView.topAnchor.constraint(equalTo: blueView.topAnchor).isActive = true
        slideMenuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor).isActive = true
        slideMenuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor).isActive = true
        slideMenuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor).isActive = true
        
        darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor).isActive = true
        darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor).isActive = true
        darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
        darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor).isActive = true
        
        addChild(slideMenuController)
        addChild(rightViewController)
    }
}
