import FirebladeECS

class TestSystem {
    init() {
        MessageBus.shared.register(listener: handleHelloWorld(message:))
    }

    func handleHelloWorld(message: HelloWorld) {
        print(message.value)
    }
}