import FirebladeECS

class TestSystem {
    init() {
        MessageBus.shared.register(listener: handleHelloWorld)
    }

    func handleHelloWorld(address: String, message: HelloWorld) {
        print(address)
        print(message.value)
    }
}