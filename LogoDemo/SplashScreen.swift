//
//  SplashScreen.swift
//  swift55NewAPIs
//
//  Created by Terry Kuo on 2021/11/9.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var startAnimation: Bool = false
    
    @Binding var endAnimation: Bool
    @State private var disappearAni: Bool = false
    
    var body: some View {
        ZStack {
            Color("SplashScreenColor")
            
            Group {
                SplashShape()
                    .offset(x: endAnimation ? 30 : 0)
                    .trim(from: 0, to: startAnimation ? 1 : 0)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
            }
            .frame(width: 220, height: 130, alignment: .center)
            .scaleEffect(endAnimation ? 0.8 : 18)
            
            VStack {
                
                Text("Joe's  © 2021")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("喬斯室內設計")
                    .font(.callout)
                    .fontWeight(.semibold)
            }
            .opacity(startAnimation ? 1 : 0)
            
            .frame(maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(Color.white.opacity(0.8))
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            
        }
        .opacity(disappearAni ? 0 : 1)
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.2)) {
                    startAnimation.toggle()
                }
                
//                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.8)) {
//                    endAnimation.toggle()
//                }
                withAnimation(.easeOut(duration: 0.5).delay(0.8)) {
                    endAnimation.toggle()
                }
                
                withAnimation(.easeOut(duration: 0.4).delay(1.1)) {
                    disappearAni.toggle()
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(endAnimation: .constant(false))
    }
}

struct SplashShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let mid = rect.width / 2
            let height = rect.height
            
            //80 = 40: Arc Radius
            path.move(to: CGPoint(x: mid - 80, y: height))
            
            path.addArc(center: CGPoint(x: mid - 40, y: height), radius: 40, startAngle: .init(degrees: 180), endAngle: .zero, clockwise: true)
            
            
            //straight line
            path.move(to: CGPoint(x: mid, y: height))
            path.addLine(to: CGPoint(x: mid, y: 0))
        }
    }
}
