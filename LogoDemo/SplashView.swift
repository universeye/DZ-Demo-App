//
//  SplashView.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/12.
//

import SwiftUI

class SplashViewDelegate: ObservableObject {
    @Published var isDismiss: Bool = false
}

struct SplashView: View {
    
    @ObservedObject var delegate: SplashViewDelegate
    @State private var endAnimation: Bool = false
    
    
    var body: some View {
        ZStack {
            Color("SplashScreenColor").ignoresSafeArea()
            
            SplashScreen(endAnimation: $endAnimation)
        }
        
        .onAppear {
            endAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                delegate.isDismiss = true
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
