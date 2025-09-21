// 数据服务 - 负责获取数据
enum UserError: Error, LocalizedError {
    case userNotFound
    
    var errorDescription: String? {
        return "User not found"
    }
}

class UserService {
    func getUser(withId id: Int, completion: @escaping (Result<User, UserError>) -> Void) {
        // 模拟网络请求
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            // 模拟返回数据
            let mockUser = User(id: id, name: "John Doe", email: "john@example.com")
            completion(.success(mockUser))
            
            // 如果要模拟错误，使用下面这行
            // completion(.failure(.userNotFound))
        }
    }
}
