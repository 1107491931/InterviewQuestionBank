// Presenter - 协调Model和View
class UserPresenter {
    weak var view: UserViewProtocol?
    private let userService: UserService
    
    init(view: UserViewProtocol, userService: UserService = UserService()) {
        self.view = view
        self.userService = userService
    }
    
    func fetchUser(withId id: Int) {
        view?.showLoading()
        
        userService.getUser(withId: id) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideLoading()
            
            switch result {
            case .success(let user):
                self.view?.displayUser(user)
            case .failure(let error):
                self.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
