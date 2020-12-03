
import UIKit

class MenuHeaderView: UIView {
    let nameLabel = UILabel()
    let userNameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()
    var followingCounting = 32
    var followersCounting = 1327
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponentProps()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error init")
    }
    
    fileprivate func setupComponentProps() {
        nameLabel.text = "Steve"
        nameLabel.font = UIFont.systemFont(ofSize: 19, weight: .heavy)
        userNameLabel.text = "@steveshelaiev98"
        userNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        userNameLabel.textColor = .lightGray
        profileImageView.image = #imageLiteral(resourceName: "Steve")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        setupStatsAttributedText()
    }
    
    fileprivate func setupStatsAttributedText() {
        var toStringFollowing = String(followingCounting)
        var toStringFollowers = String(followersCounting)
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "\(toStringFollowing) ",attributes: [.font: UIFont.systemFont(ofSize: 18,weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ",attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "\(toStringFollowers) ",attributes: [.font: UIFont.systemFont(ofSize: 18,weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers",attributes: [.foregroundColor: UIColor.black]))
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        let arrangedSubviews = [
                                UIStackView(arrangedSubviews: [profileImageView,UIView()]),nameLabel,
                                userNameLabel,SpacerView(space: 16),statsLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 3
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
    }
}

class SpacerView: UIView {
    let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
    init(space: CGFloat){
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Problem to init spacing")
    }
}
