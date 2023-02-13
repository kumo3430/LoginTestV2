//
//  AddSportWalk.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddSportWalk: View {
    
    @ObservedObject var viewModel: SportWalkInsertViewModel

    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    
    @State var shouldShowImagePicker = false
    
    var body: some View {
        NavigationStack {
            VStack{
                // 輸入帳號密碼
                Group {
                    // 將帳號密碼的資料存放到LoginInsertViewModel的eamil
                    HStack {
                        Text("名稱：")
                        TextField("習慣名稱", text:$viewModel.task_name)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    HStack {
                        Text("備注：")
                        // 將帳號密碼的資料存放到LoginInsertViewModel的password
                        SecureField("備注", text:$viewModel.note)
                    }
                }
                .padding(12)
                .background(Color.white)
                
                Button{
                    // 功能保留
//                        handleAction()
                    // 測試 未來可移入登入判斷
                    // 執行在LoginInsertViewMode的 onAddButtonClikck()
                    viewModel.onAddButtonClick()
                    print(123)
                } label: {
                    HStack{
                        Spacer()
                        Text(isLoginMode ? "Log In" : "Create Account")
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

struct AddSportWalk_Previews: PreviewProvider {
    static var previews: some View {
        AddSportWalk(viewModel: SportWalkInsertViewModel())
    }
}
