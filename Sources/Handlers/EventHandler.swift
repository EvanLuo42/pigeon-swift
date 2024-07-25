import NIO
import SwiftProtobuf

final class EventHandler: ChannelInboundHandler {
    typealias InboundIn = Message

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let proto = self.unwrapInboundIn(data)
        MessageBus.shared.post(message: proto)
    }
}