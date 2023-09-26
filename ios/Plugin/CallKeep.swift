import Foundation

@objc public class CallKeep: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
