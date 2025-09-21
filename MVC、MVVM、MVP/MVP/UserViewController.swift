// View - 视图控制器实现
import UIKit

class UserViewController: UIViewController, UserViewProtocol {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let presenter: UserPresenter
    
    init(userId: Int) {
        self.presenter = UserPresenter(view: self)
        super.init(nibName: "UserViewController", bundle: nil)
        // 可以在这里传递用户ID
    }
    
    required init?(coder: NSCoder) {
        self.presenter = UserPresenter(view: self)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 请求用户数据
        presenter.fetchUser(withId: 1)
    }
    
    // MARK: - UserViewProtocol
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func displayUser(_ user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
