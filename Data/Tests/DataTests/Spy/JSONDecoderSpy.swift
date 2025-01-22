import Foundation

final class JSONDecoderSpy: JSONDecoder {
    public private(set) var decodeCalled = false
    public private(set) var decodeTypePassed: Any.Type?
    public private(set) var decodeDataPassed: Data?
    public var errorToBeThrow: NSError?
    
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        decodeCalled = true
        decodeTypePassed = type
        decodeDataPassed = data
        if let error = errorToBeThrow {
            throw error
        }
        return try super.decode(type, from: data)
    }
}
