import Foundation
import NIO

let testSystem = TestSystem()

let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
let bootstrap = ServerBootstrap(group: group)
    .serverChannelOption(ChannelOptions.backlog, value: 256)
    .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
    .childChannelInitializer { channel in
        channel.pipeline.addHandlers([
            ByteToMessageHandler(ProtobufDecoder()),
            EventHandler()])
    }
    .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
    .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
    .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())

let host = "127.0.0.1"
let port = 8888

let channel = try bootstrap.bind(host: host, port: port).wait()
print("Server started and listening on \(channel.localAddress!)")
try channel.closeFuture.wait()
print("Server closed")
