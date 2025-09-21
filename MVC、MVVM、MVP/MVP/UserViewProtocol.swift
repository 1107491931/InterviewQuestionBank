// View协议 - 定义视图需要实现的方法
protocol UserViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displayUser(_ user: User)
    func displayError(message: String)
}
