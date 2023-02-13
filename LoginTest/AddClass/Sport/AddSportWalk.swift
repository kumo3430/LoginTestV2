//
//  AddSportWalk.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddSportWalk: View {
    
    @ObservedObject var viewModel: SportWalkInsertViewModel
    
    @State var set_up_time: Date = Date()
    
    let classification = ["學習","運動","生活","作息"]
    @State var _classification: Int = 1
    let sub_classification = ["健走","跑步","游泳","騎車"]
    @State var _sub_classification: Int = 0
    @State var task_name: String = ""
    @State var tag_id1: Int = 0     //
    @State var quantity: Int?
    @State var begin: Date = Date()     //
    @State var finish: Date = Date()        //
    //@State var fulfill: Int = 0
    let cycle = ["日","週","月"]
    @State var _cycle: Int = 0
    @State var note: String = ""
    @State var alert_time: Date = Date()
    //@State var show_to_club: String = ""
    //@State var completion: Int = 0
    @State var uid: Int = 0     //
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    
                    Group {
                        HStack {
                        Text("類別：")
                            Picker(selection: $_classification) {
                                Text(classification[0]).tag(0)
                                Text(classification[1]).tag(1)
                                Text(classification[2]).tag(2)
                                Text(classification[3]).tag(3)
                            } label: {
                                Text("選擇大類別")
                            }
                            Picker(selection: $_sub_classification) {
                                Text(sub_classification[0]).tag(0)
                                Text(sub_classification[1]).tag(1)
                                Text(sub_classification[2]).tag(2)
                                Text(sub_classification[3]).tag(3)
                            } label: {
                                Text("選擇大類別")
                            }
                        }
                        // 將帳號密碼的資料存放到LoginInsertViewModel的eamil
                        HStack {
                            Text("名稱：")
                            TextField("習慣名稱", text:$viewModel.task_name)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        HStack {
                            Text("標籤：")
                        }
//                        HStack {
//                            DatePicker("開始日期：", selection: $viewModel.begin,displayedComponents: .date)
//                            
//                        }
//                        HStack {
//                            DatePicker("結束日期：", selection: $viewModel.alert_time,displayedComponents: .date)
//                            
//                        }
                        HStack {
                            Text("目標：")
                            TextField("km", value:$viewModel.quantity, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .padding()
                            Text("Km    /")
                            Picker(selection: $_cycle) {
                                Text(cycle[0]).tag(0)
                                Text(cycle[1]).tag(1)
                                Text(cycle[2]).tag(2)
                            } label: {
                                Text("選擇大類別")
                            }
                        }
                        HStack {
                            Text("備注：")
                            // 將帳號密碼的資料存放到LoginInsertViewModel的password
                            TextField("備注", text:$viewModel.note)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .padding()
                        }
                        HStack {
                            DatePicker("提醒時間：", selection: $viewModel.alert_time,displayedComponents: .hourAndMinute)
                            
                        }
//                        HStack {
//                            Text("分享社群：")
//                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button{
                        viewModel.onAddButtonClick()
                        print(123)
                    } label: {
                        HStack{
                            Spacer()
                            Text("完成")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14,weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                }
                .navigationTitle("運動")
            }
            
        }
    }
}

struct AddSportWalk_Previews: PreviewProvider {
    static var previews: some View {
        AddSportWalk(viewModel: SportWalkInsertViewModel())
    }
}
