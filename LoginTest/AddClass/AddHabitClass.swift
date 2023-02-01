//
//  AddHabitClass.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/1.
//

import SwiftUI

struct AddHabitClass: View {
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack {
                    Text("習慣建立")
                    NavigationLink {
                        AddStudyGeneral()
                    } label: {
                        Text("學習")
                    }
                }
            }
        }
        
    }
}

struct AddHabitClass_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitClass()
    }
}
