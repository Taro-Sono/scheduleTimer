//
//  ContentViewModel.swift
//  ListTimer
//
//  Created by 宗野太郎 on 2023/08/04.
//

import Foundation
//event1用
extension ContentView {
    final class ViewMode2: ObservableObject {
        @Published var isLarge2 = true
        @Published var isNext2 = true
        @Published var isActive2 = false
        @Published var showingAlert2 = false
        @Published var time2: String = "0:0:00"
        @Published var hours2: Float = 0.0 {
            didSet {
                self.time2 = "\(Int(hours2)):\(Int(minutes2)):00"
            }
        }
        
        @Published var minutes2: Float = 0.0 {
            didSet {
                self.time2 = "\(Int(hours2)):\(Int(minutes2)):00"
            }
        }
        
        //self.はメンバ関数にアクセスしている証拠
        private var initialTime2 = 0
        private var endDate2 = Date() //現在時刻の取得
        
        func start2() {
            self.endDate2 = Date()  //start時の時刻取得
            self.isActive2 = true
            self.endDate2 = Calendar.current.date(byAdding: .hour, value: Int(hours2) , to: endDate2)!//addした時間だけ進んだ時間を取得
            self.endDate2 = Calendar.current.date(byAdding: .minute, value: Int(minutes2), to: endDate2)!
            self.isLarge2 = false
        }
        
        func reset2() {
            self.hours2 = Float(initialTime2)
            self.minutes2 = Float(initialTime2)
            self.isActive2 = false
            self.time2 = "0:0:00"
            self.isLarge2 = true
        }
        
        func updateCountDown2() {
            guard isActive2 else { return }
            
            let now2 = Date() //起動中の時刻、常に変化
            let diff2 = endDate2.timeIntervalSince(now2)//enddateとnowの時間差

            
            if diff2 <= 0 {
                self.isActive2 = false
                self.time2 = "0:0:00"
                return
            }
            
        
            
            let date = Date(timeIntervalSince1970: diff2)//秒を1970年基準に直す
            //カレンダー作成
            let calendar = Calendar.current
            //それぞれの値を取り出す
            let hours = calendar.component(.hour, from: date) - 9
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            self.hours2 = Float(hours)
            self.minutes2 = Float(minutes)
            self.time2 = String(format: "%d:%d:%02d", hours, minutes, seconds)
        }
                
        
    }
}
