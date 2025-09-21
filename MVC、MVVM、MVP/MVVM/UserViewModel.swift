// ViewModel - 业务逻辑和数据处理
import Foundation

class UserViewModel {
    // 数据模型
    private var user: User? {
        didSet {
            updateUserInfo()
        }
    }
    
    // 供View绑定的属性
    var userName: String = "Loading..." {
        didSet {
            userNameDidChange?(userName)
        }
    }
    
    var userEmail: String = "" {
        didSet {
            userEmailDidChange?(userEmail)
        }
    }
    
    var registrationDate: String = "" {
        didSet {
            registrationDateDidChange?(registrationDate)
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            isLoadingDidChange?(isLoading)
        }
    }
    
    var errorMessage: String? {
        didSet {
            errorMessageDidChange?(errorMessage)
        }
    }
    
    // 数据变化回调（替代第三方绑定库）
    var userNameDidChange: ((String) -> Void)?
    var userEmailDidChange: ((String) -> Void)?
    var registrationDateDidChange: ((String) -> Void)?
    var isLoadingDidChange: ((Bool) -> Void)?
    var errorMessageDidChange: ((String?) -> Void)?
    
    // 加载用户数据
    func loadUser(withId id: Int) {
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                // 模拟请求结果
                if id == 1 {
                    // 成功获取数据
                    let sampleUser = User(
                        id: 1,
                        name: "John Doe",
                        email: "john.doe@example.com",
                        registrationDate: Date(timeIntervalSinceNow: -30*24*60*60) // 30天前
                    )
                    self?.user = sampleUser
                } else {
                    // 失败情况
                    self?.errorMessage = "User with ID \(id) not found"
                }
            }
        }
    }
    
    // 更新用户信息展示格式
    private func updateUserInfo() {
        guard let user = user else { return }
        
        userName = user.name
        userEmail = user.email
        
        // 格式化日期
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        registrationDate = "Registered: \(dateFormatter.string(from: user.registrationDate))"
    }
}
