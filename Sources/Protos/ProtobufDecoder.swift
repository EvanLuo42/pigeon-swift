import NIO
import SwiftProtobuf

final class ProtobufDecoder: ByteToMessageDecoder {
    typealias InboundOut = Message

    let protos: [UInt16 : Message.Type] = [
        1: HelloWorld.self
    ]

    func decode(context: ChannelHandlerContext, buffer: inout ByteBuffer) throws -> DecodingState {
        if buffer.readableBytes == 0 {
            return .needMoreData
        }

        guard let tag = buffer.readInteger(as: UInt16.self) else {
            return .needMoreData
        }

        guard let length = buffer.readInteger(as: UInt16.self) else {
            return .needMoreData
        }

        guard let value = buffer.readBytes(length: Int(length)) else {
            return .needMoreData
        }

        guard let type: any Message.Type = protos[tag] else {
            throw PigeonError.protoDecode
        }

        let proto = try type.init(serializedBytes: value)
        context.fireChannelRead(self.wrapInboundOut(proto))
        return .continue
    }

    func decodeLast(context: ChannelHandlerContext, buffer: inout ByteBuffer, seenEOF: Bool) throws -> DecodingState {
        return .needMoreData
    }
}