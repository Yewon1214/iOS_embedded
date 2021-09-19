//
//  SocketIOManager.swift
//  httptest
//
//  Created by 허예원 on 2021/07/24.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    //var manager = SocketManager(socketURL: URL(string: "http://192.168.35.167:9000")!, config: [.log(true), .compress])
    var manager = SocketManager(socketURL: URL(string: "http://172.30.1.33:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    let userNofiCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        socket = self.manager.defaultSocket
        
        requestAuthNoti()

        socket.on("accident"){ dataArray , ack in
            //알림 주기
            self.requestSendNoti(seconds: 3)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(socketMessage: String, message: String) {
        socket.emit(socketMessage, message)
    }
    
    func requestAuthNoti(){
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNofiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error{
                print(#function, error)
            }
        }
    }
    
    func requestSendNoti(seconds: Double){
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "사고 알림"
        notiContent.body = "본인의 차량에 사고가 발생했습니다. 신고하시겠습니까?"
        notiContent.userInfo = ["targetScene": "splash"]
        notiContent.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notiContent, trigger: trigger)
        
        userNofiCenter.add(request){ (error) in
            print(#function, error)
        }
    }
}
