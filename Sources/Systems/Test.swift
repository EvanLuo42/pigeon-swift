import FirebladeECS

class TestSystem {
    init() {
        MessageBus.shared.register(listener: handleHelloWorld)
    }

    func handleHelloWorld(ip: String, message: HelloWorld) {
        print(message.value)
    }
}