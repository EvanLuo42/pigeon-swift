import NIO

final class ChannelsHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer

    private var channels: [String: any Channel] = [:]

    func channelActive(context: ChannelHandlerContext) {
        guard let address = context.channel.remoteAddress else {
            context.close(promise: nil)
            return
        }
        guard let ip = address.ipAddress, let port = address.port else {
            context.close(promise: nil)
            return
        }
        channels["\(ip):\(port)"] = context.channel
    }

    func channelInactive(context: ChannelHandlerContext) {
        guard let address = context.channel.remoteAddress else {
            context.close(promise: nil)
            return
        }
        guard let ip = address.ipAddress, let port = address.port else {
            context.close(promise: nil)
            return
        }
        channels["\(ip):\(port)"] = nil
    }
}