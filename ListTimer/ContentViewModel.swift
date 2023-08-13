//
//  ContentViewModel.swift
//  ListTimer
//
//  Created by 宗野太郎 on 2023/08/04.
//

import Foundation
import AudioToolbox
import UserNotifications
//event1用
extension ContentView {
    final class ViewModel: ObservableObject {
        @Published var isLarge = true
        @Published var isNext = true
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "0:0:00"
        @Published var hours: Float = 0.0 {
            didSet {
                self.time = "\(Int(hours)):\(Int(minutes)):00"
            }
        }
        
        @Published var minutes: Float = 0.0 {
            didSet {
                self.time = "\(Int(hours)):\(Int(minutes)):00"
            }
        }
        
        //self.はメンバ関数にアクセスしている証拠
        private var initialTime = 0
        private var endDate = Date() //現在時刻の取得
        
        func start() {
            self.endDate = Date()  //start時の時刻取得
            self.isActive = true
            self.endDate = Calendar.current.date(byAdding: .hour, value: Int(hours) , to: endDate)!//addした時間だけ進んだ時間を取得
            self.endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
            self.isLarge = false
        }
        
        func reset() {
            self.hours = Float(initialTime)
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "0:0:00"
            self.isLarge = true
        }
        
        func updateCountDown() {
            guard isActive else { return }
            
            let now = Date() //起動中の時刻、常に変化
            let diff = endDate.timeIntervalSince(now)//enddateとnowの時間差

            
            if diff <= 0 {
                self.isActive = false
                self.time = "0:0:00"
                self.showingAlert = true
                self.notification()
                for _ in 0...2 {
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)){}
                    sleep(1)
                }
                return
            }
            
            
        
            
            let date = Date(timeIntervalSince1970: diff)//秒を1970年基準に直す
            //カレンダー作成
            let calendar = Calendar.current
            //それぞれの値を取り出す
            let hours = calendar.component(.hour, from: date) - 9
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.hours = Float(hours)
            self.minutes = Float(minutes)
            self.time = String(format: "%d:%d:%02d", hours, minutes, seconds)
        }
        
        func notificationConfirm() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]){(granted,_) in
                if granted{
                    
                } else{
                    
                }
            }
        }
        func notification() {
                let content  = UNMutableNotificationContent()
                content.title = "List Timer"
                content.body = "Time done"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
            }        
                
        
    }
}
