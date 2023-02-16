//
//  ChooseTag.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/15.
//

import SwiftUI

struct ChooseTag: View {
    @ObservedObject var viewModel: TagInsertViewModel
    @State var tagName: String = ""
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack{
                    HStack {
                        Text("名稱：")
                        TextField("習慣名稱", text:$viewModel.tagName)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .padding()
                        Button {
                            viewModel.onAddButtonClick()
                            print(123)
                        } label: {
                                Text("建立")
                            }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("建立標籤")
        }
        
    }
}

struct ChooseTag_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTag(viewModel: TagInsertViewModel())
    }
}
