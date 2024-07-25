import SwiftProtobuf
import Dispatch

class MessageBus {
    static let shared = MessageBus()

    private var listeners: [String: [(String, Message) -> Void]] = [:]

    func register<T: Message>(listener: @escaping (String, T) -> Void) {
        let messageName = String(describing: type(of: T.self))
        let wrappedListener: (String, Any) -> Void = { ip, message in
            if let message = message as? T {
                listener(ip, message)
            }
        }

        if listeners[messageName] == nil {
            listeners[messageName] = []
        }
        listeners[messageName]?.append(wrappedListener)
    }

    func post<T: Message>(ip: String, message: T) {
        listeners[String(describing: type(of: T.self))]?.forEach { listener in
            DispatchQueue.ecs.sync {
                listener(ip, message)
            }
        }
    }
}

extension DispatchQueue {
    static let ecs = DispatchQueue(label: "ecs")
}