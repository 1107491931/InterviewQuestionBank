/**
 简单工厂模式:  通过一个单一工厂类负责创建所有相关类型的对象，根据输入参数决定创建哪种具体产品。
 抽象工厂模式: 提供一个抽象工厂接口，由多个具体工厂类实现，每个具体工厂负责创建一整套相关 / 依赖的产品家族（多个产品类型)。

 简单工厂模式：
    特点：工厂类是具体的（非抽象），通过条件判断（如switch）决定创建哪种产品。
    场景：通过enum创建不用的vc
 抽象工厂模式：
   特点：工厂是抽象的，每个具体工厂对应一个产品家族，无需条件判断即可创建一组相关产品。
   场景：页面换肤， 不同工厂创建不同的多个组件类型
 */


// 简单工厂模式
protocol Button {
    func render()
}

class SystemButton: Button {
    func render() {
        print("渲染一个系统风格的按钮")
    }
}

class RoundedButton: Button {
    func render() {
        print("渲染一个圆角风格的按钮")
    }
}

class ButtonFactory {
    static func createButton(type: ButtonType) -> Button {
        switch type {
        case .system:
            return SystemButton()
        case .rounded:
            return RoundedButton()
        }
    }
}

enum ButtonType {
    case system
    case rounded
}

let systemButton = ButtonFactory.createButton(type: .system)
systemButton.render()



// 抽象工厂模式
// 产品协议
protocol Button {
    func render() -> String
}

protocol Alert {
    func show() -> String
}

// 具体产品
class IOSButton: Button {
    func render() -> String {
        return "渲染iOS风格按钮"
    }
}

class AndroidButton: Button {
    func render() -> String {
        return "渲染Android风格按钮"
    }
}

class IOSAlert: Alert {
    func show() -> String {
        return "显示iOS风格弹窗"
    }
}

class AndroidAlert: Alert {
    func show() -> String {
        return "显示Android风格弹窗"
    }
}

// 抽象工厂协议
protocol UIFactory {
    func createButton() -> Button
    func createAlert() -> Alert
}

// 具体工厂
class IOSFactory: UIFactory {
    func createButton() -> Button {
        return IOSButton()
    }
    
    func createAlert() -> Alert {
        return IOSAlert()
    }
}

class AndroidFactory: UIFactory {
    func createButton() -> Button {
        return AndroidButton()
    }
    
    func createAlert() -> Alert {
        return AndroidAlert()
    }
}

// 使用
let factory = IOSFactory()
let button = factory.createButton()
let alert = factory.createAlert()
print(button.render()) // 输出: 渲染iOS风格按钮
print(alert.show()) // 输出: 显示iOS风格弹窗
