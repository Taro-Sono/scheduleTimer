//
//  ContentView.swift
//  ListTimer
//
//  Created by 宗野太郎 on 2023/08/03.
//

import SwiftUI
import AudioToolbox
import UserNotifications

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    @StateObject private var vm2 = ViewMode2()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var event1 = ""
    @State private var event2 = ""
    @State private var event3 = ""
    @State private var event4 = ""
    @State private var event = ""
    @State private var hour1: Float = 0.0
    @State private var minutes1: Float = 0.0
    @State private var hour2: Float = 0.0
    @State private var minutes2: Float = 0.0
    @State private var hour3: Float = 0.0
    @State private var minutes3: Float = 0.0
    @State private var hour4: Float = 0.0
    @State private var minutes4: Float = 0.0
    @State private var isNext = true
    @State private var isStart = true
    @State private var isSet = false
    @State private var timeList:[Float] = []
    @State private var subjectList:[String] = []
    @State private var hourListCount = 0
    @State private var minutesListCount = 1
    @State private var eventListCount = 0
    
    
    var body: some View {
        NavigationView {
            let timeList = [hour1, minutes1, hour2, minutes2, hour3, minutes3, hour4, minutes4]
            let subjectList = [event1, event2, event3, event4]
            VStack {
                Spacer()
                    .frame(height: 70)
                //入力欄
                HStack {
                    TextField("予定1", text: $event1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    TextField("0", value: $hour1, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("00", value: $minutes1, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    Text("00")
                        .padding(.trailing, 10)
                }
                
                HStack {
                    TextField("予定2", text: $event2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    TextField("0", value: $hour2, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("00", value: $minutes2, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    Text("00")
                        .padding(.trailing, 10)
                }
                
                HStack {
                    TextField("予定3", text: $event3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    TextField("0", value: $hour3, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("00", value: $minutes3, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    Text("00")
                        .padding(.trailing, 10)
                }
                
                HStack {
                    TextField("予定4", text: $event4)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                    TextField("0", value: $hour4, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    TextField("00", value: $minutes4, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(":")
                    Text("00")
                        .padding(.trailing, 10)
                }
                
                //一番最初だけ
//                Button {
//                    let timeList = [hour1, minutes1, hour2, minutes2, hour3, minutes3,hour4,minutes4]
//                    print("\(timeList)")
//                    vm.hours = timeList[hourListCount]
//                    vm.minutes = timeList[minutesListCount]
//                    isStart = false
//                    vm.notificationConfirm()
//                } label: {
//                    Text("set")
//                }
//                .disabled(isSet)
                Spacer()
                    .frame(height: 30)
                
                //リストネーム
                HStack {
                    ZStack {
                        let event = subjectList[eventListCount]
                        Text("\(event)")//textfieldにする
                        
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                            .cornerRadius(20)
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    
                    //時間表示
                    ZStack(alignment: .center) {
                        Text("\(vm.time)") //時間を直接入力できるように
                            .font(.system(size: 50))
                            .alert("Time done", isPresented: $vm.showingAlert) {
                                if hour2 == 0 && minutes2 == 0 && hour3 == 0 && minutes3 == 0 && hour4 == 0 && minutes4 == 0 {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                        
                                    } label: {
                                        Text("finish")
                                    }
                                } else if hourListCount == 0 && minutesListCount == 1 && hour2 == 0 && minutes2 == 0 {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                    } label: {
                                        Text("finish")
                                    }
                                } else if hourListCount == 2 && minutesListCount == 3 && hour3 == 0 && minutes3 == 0 {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                    } label: {
                                        Text("finish")
                                    }
                                } else if hourListCount == 4 && minutesListCount == 5 && hour4 == 0 && minutes4 == 0 {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                    } label: {
                                        Text("finish")
                                    }
                                } else if hourListCount >= 6 && minutesListCount >= 7  {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                    } label: {
                                        Text("finish")
                                    }
                                } else {
                                    Button(role: .cancel) {
                                        vm.isLarge = true
                                        isSet = false
                                        isStart = true
                                        hourListCount = 0
                                        minutesListCount = 1
                                    } label: {
                                        Text("finish")
                                    }
                                    
                                    Button {
                                        hourListCount += 2
                                        minutesListCount += 2
                                        eventListCount += 1
                                        vm.hours = timeList[hourListCount]
                                        vm.minutes = timeList[minutesListCount]
                                        event = subjectList[eventListCount]
                                        vm.start()
                                        print("\(timeList[hourListCount]);")
                                        print("\(timeList[minutesListCount]);;")
                                    } label: {
                                        Text("continue")
                                    }
                                }
                            }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    }
                    .frame(width: 250, height: 100)
                    .padding(.trailing, 20)
                }
                .scaleEffect(vm.isLarge ?  0.7 : 1)
                .animation(.default, value: vm.isLarge)
                
                Spacer()
                    .frame(height: 200)
                
                //start,reset
                HStack {
                    Button {
                        vm.start()
                        isSet = true
                    } label: {
                        Text("Start")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(.green)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .shadow(color: .init(white: 0.5, opacity: 0.3), radius: 10, x: 0, y: 0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.init(white: 1, opacity:  0.6), lineWidth: 1))
                        
                    }
                    .disabled(isStart)
                    .disabled(vm.isActive)
                    
                    
                    Spacer()
                        .frame(width: 50)
                    
                    Button {
                        vm.reset()
                        isSet = false
                        isStart = true
                    } label: {
                        Text("Reset")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.ultraThinMaterial)
                                    .shadow(color: .init(white: 0.5, opacity: 0.3), radius: 10, x: 0, y: 0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.init(white: 1, opacity: 0.6), lineWidth: 1))
                    }
                    
                    
                }
                Spacer()
                    .frame(height: 100)
            }
            .onReceive(timer) { _ in
                vm.updateCountDown()
            }
            .navigationBarTitle("Timer", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        let timeList = [hour1, minutes1, hour2, minutes2, hour3, minutes3,hour4,minutes4]
                        print("\(timeList)")
                        vm.hours = timeList[hourListCount]
                        vm.minutes = timeList[minutesListCount]
                        isStart = false
                        vm.notificationConfirm()
                    } label: {
                        Text("set")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                    }
                    .disabled(isSet)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
