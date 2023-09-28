import Foundation
import Capacitor
import PushKit
import UIKit
import CallKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CallKeepPlugin)
public class CallKeepPlugin: CAPPlugin {

    private let implementation = CallKeep()
    private var provider: CXProvider?
    private let voipRegistry = PKPushRegistry(queue: nil)
    private var connectionIdRegistry : [UUID: CallConfig] = [:]

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func register(_ call: CAPPluginCall) {
        // config PushKit
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [.voIP]

        let config = CXProviderConfiguration(localizedName: "Shwid Call")
        config.supportsVideo = true
        config.maximumCallGroups = 1
        config.maximumCallsPerCallGroup = 1
        config.supportedHandleTypes = [.generic]
        
        provider = CXProvider(configuration: config)
        //provider?.setDelegate(self, queue: DispatchQueue.main)
        
        call.resolve()
    }
    
    
    public func notifyEvent(eventName: String, uuid: UUID){
        if let config = connectionIdRegistry[uuid] {
            notifyListeners(eventName, data: [
                "id": config.id,
                "media": config.media,
                "name"    : config.name,
                "duration"    : config.duration,
            ])
            connectionIdRegistry[uuid] = nil
        }
    }
    
    
    public func incomingCall(id: String, media: String, name: String, duration: String) {
        let update                      = CXCallUpdate()
        update.remoteHandle             = CXHandle(type: .generic, value: name)
        update.hasVideo                 = media == "video"
        update.supportsDTMF             = false
        update.supportsHolding          = true
        update.supportsGrouping         = false
        update.supportsUngrouping       = false
        let uuid = UUID()
        connectionIdRegistry[uuid] = .init(id: id, media: media, name: name, duration: duration)
        self.provider?.reportNewIncomingCall(with: uuid, update: update, completion: { (_) in })
    }
    
    
    public func endCall(uuid: UUID) {
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXEndCallAction(call: uuid));controller.request(transaction,completion: { error in })
    }

}


extension CallKeepPlugin: CXProviderDelegate {
    public func providerDidReset(_ provider: CXProvider) {
    }
    
    public func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        // Answers an incoming call
        print("CXAnswerCallAction answers an incoming call")
        notifyEvent(eventName: "callAnswered", uuid: action.callUUID)
        endCall(uuid: action.callUUID)
        action.fulfill()
    }
    
    public func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        // End the call
        print("CXEndCallAction represents ending call")
        notifyEvent(eventName: "callEnded", uuid: action.callUUID)
        action.fulfill()
    }
    
    public func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        // Report connection started
        print("CXStartCallAction represents initiating an outgoing call")
        notifyEvent(eventName: "callStarted", uuid: action.callUUID)
        action.fulfill()
    }
}


extension CallKeepPlugin: PKPushRegistryDelegate {
    public func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        let parts = pushCredentials.token.map { String(format: "%02.2hhx", $0) }
        let token = parts.joined()
        print("Token: \(token)")
        notifyListeners("registration", data: ["value": token])
    }
    
    public func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print("didReceiveIncomingPushWith")
  
        guard let arrPayloadData = payload.dictionaryPayload["custom"] as? [String: Any] else { return }
        guard let data = arrPayloadData["a"] as? [String:Any] else { return }
        
        guard let id:String = data["id"] as? String else { return }
        let name:String = data["name"] as? String ?? "Unknown"
        let media:String = data["media"] as? String ?? "audio"
        let duration:String = data["duration"] as? String ?? "0"
        
        print("id: \(id)")
        print("name: \(name)")
        print("media: \(media)")
        print("duration: \(duration)")
        self.incomingCall(id: id, media: media, name: name, duration: duration)
    }
    
}

extension CallKeepPlugin {
    struct CallConfig {
        let id: String
        let media: String
        let name: String
        let duration: String
    }
}
