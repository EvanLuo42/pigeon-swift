import SwiftProtobuf
import Dispatch

class MessageBus {
    static let shared = MessageBus()

    private var listeners: [String: [(Message) -> Void]] = [:]

    func register<T: Message>(listener: @escaping (T) -> Void) {
        let messageName = String(describing: type(of: T.self))
        let wrappedListener: (Any) -> Void = { message in
            if let message = message as? T {
                listener(message)
            }
        }

        if listeners[messageName] == nil {
            listeners[messageName] = []
        }
        listeners[messageName]?.append(wrappedListener)
    }

    func post<T: Message>(message: T) {
        listeners[String(describing: type(of: T.self))]?.forEach { listener in
            DispatchQueue.ecs.sync {
                listener(message)
            }
        }
    }
}

extension DispatchQueue {
    static let ecs = DispatchQueue(label: "ecs")
}