//
//  AddStudyGeneral.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddStudyGeneral: View {
    
//    @Published var taskName: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack(spacing: 20) {
                    Text("名稱：")
                    //TextField("Task Name", text: $viewModel.taskName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()

                HStack(spacing: 20) {
                    Text("Start Date  :")
                    //DatePicker("", selection: $viewModel.startDate)
                    Spacer()
                }
                .padding()

                HStack {
                    Button(action: {
                        //viewModel.onAddButtonClick()
                    }) {
                        Text("Add")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                    }
                    .background(.blue)
                    .cornerRadius(.infinity)
                    .padding()
                }
                Spacer()
            }
            .navigationTitle("學習")
        }
        
    }
}

struct AddStudyGeneral_Previews: PreviewProvider {
    static var previews: some View {
        AddStudyGeneral()
    }
}
