// View - 视图控制器
import UIKit

class UserViewController: UIViewController {
    // UI组件
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let dateLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let reloadButton = UIButton(type: .system)
    
    // ViewModel实例
    private let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        
        // 初始加载用户数据
        viewModel.loadUser(withId: 1)
    }
    
    // 设置UI
    private func setupUI() {
        view.backgroundColor = .white
        
        // 配置标签
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        emailLabel.font = .systemFont(ofSize: 18)
        dateLabel.font = .systemFont(ofSize: 16)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        // 配置按钮
        reloadButton.setTitle("Reload Data", for: .normal)
        reloadButton.addTarget(self, action: #selector(reloadTapped), for: .touchUpInside)
        
        // 布局
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel, dateLabel, errorLabel, reloadButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // 绑定ViewModel和View
    private func bindViewModel() {
        // 绑定用户名
        viewModel.userNameDidChange = { [weak self] name in
            self?.nameLabel.text = name
        }
        
        // 绑定邮箱
        viewModel.userEmailDidChange = { [weak self] email in
            self?.emailLabel.text = email
        }
        
        // 绑定注册日期
        viewModel.registrationDateDidChange = { [weak self] date in
            self?.dateLabel.text = date
        }
        
        // 绑定加载状态
        viewModel.isLoadingDidChange = { [weak self] isLoading in
            if isLoading {
                self?.loadingIndicator.startAnimating()
                self?.nameLabel.isHidden = true
                self?.emailLabel.isHidden = true
                self?.dateLabel.isHidden = true
            } else {
                self?.loadingIndicator.stopAnimating()
                self?.nameLabel.isHidden = false
                self?.emailLabel.isHidden = false
                self?.dateLabel.isHidden = false
            }
        }
        
        // 绑定错误信息
        viewModel.errorMessageDidChange = { [weak self] message in
            self?.errorLabel.isHidden = message == nil
            self?.errorLabel.text = message
        }
    }
    
    // 重新加载按钮点击事件
    @objc private func reloadTapped() {
        viewModel.loadUser(withId: 1)
    }
}
