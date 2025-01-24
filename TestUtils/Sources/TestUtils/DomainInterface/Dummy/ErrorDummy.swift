import Foundation

public enum ErrorDummy: String, Error {
    case completionCantBeNil = "completion nil"
    case wrongTypePassed = "passed wrong type"
    case genericError = "generic error"
}
