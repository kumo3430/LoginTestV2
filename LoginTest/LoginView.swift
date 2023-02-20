//
//  ContentView.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginInsertViewModel

    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    
    @State var shouldShowImagePicker = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:16){
                    // 上方選擇桿
                    Picker(selection: $isLoginMode, label: Text("Picker here")){
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    // 輸入帳號密碼
                    Group {
                        // 將帳號密碼的資料存放到LoginInsertViewModel的eamil
                        TextField("Email", text:$viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        // 將帳號密碼的資料存放到LoginInsertViewModel的password
                        SecureField("password", text:$viewModel.password)
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
                .padding()
                
            }
            // 開頭
            // 打開此畫面最一開始會先執行此行
            // 執行LoginInsertViewMode 的 getTaskList()
            .onAppear {
                viewModel.getTaskList()
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
        }
    }
    //以下保留判斷是否為新增或登入所需的東西
/*
    private func handleAction(){
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        //FirebaseManager.
    }
    
//    @State var loginStatusMessage = ""
    // 創建帳戶
    private func createNewAccount() {
        
    }
 */
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginInsertViewModel())
    }
}

