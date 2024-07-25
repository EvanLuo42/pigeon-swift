import NIO

final class ChannelsHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer

    private var channels: [String: any Channel] = [:]

    func channelActive(context: ChannelHandlerContext) {
        channels[context.channel.localAddress!.ipAddress!] = context.channel
    }

    func channelInactive(context: ChannelHandlerContext) {
        channels[context.channel.localAddress!.ipAddress!] = nil
    }
}