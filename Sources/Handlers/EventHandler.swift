import NIO
import SwiftProtobuf

final class EventHandler: ChannelInboundHandler {
    typealias InboundIn = Message

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let proto = self.unwrapInboundIn(data)
        guard let address = context.channel.remoteAddress else {
            context.close(promise: nil)
            return
        }
        guard let ip = address.ipAddress, let port = address.port else {
            context.close(promise: nil)
            return
        }
        MessageBus.shared.post(address: "\(ip):\(port)", message: proto)
    }
}