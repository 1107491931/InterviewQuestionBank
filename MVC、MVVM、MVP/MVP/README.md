MVP模式引入了Presenter层，用于处理业务逻辑和数据处理。View层负责展示数据和与用户交互，而Presenter层则负责处理业务逻辑和数据处理。Presenter层与View层通过协议进行通信，View层将用户交互事件传递给Presenter层，而Presenter层则根据业务逻辑处理数据并将结果返回给View层进行展示。

Presenter层是完全独立的，不依赖View的代码
- View直接调用Presenter的方法
- Presenter中仅通过Protocol类型引用到View， 通过Protocol调用View的方法

示例代码中:
- UserViewProtocol: 定义了View层与Presenter层进行通信的协议，包含展示用户信息和错误信息的方法。
- UserPresenter: 实现了业务逻辑和数据处理，与View层通过协议进行通信。
- UserViewController: 实现了View层的逻辑，与Presenter层进行通信以获取用户数据并展示。
- UserModel: 定义了用户数据的模型，包含用户的姓名和邮箱。
- UserService: 负责与后端进行数据交互，获取用户数据。