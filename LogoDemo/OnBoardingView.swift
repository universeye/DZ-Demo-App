//
//  OnBoardingView.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/2.
//

import SwiftUI
import UIKit

class ContentViewDelegate: ObservableObject {
    @Published var isDismiss: Bool = false
}

struct OnBoardingView: View {
    
    @ObservedObject var delegate: ContentViewDelegate
    @State var isShowLogoVC = false
    @State private var endAnimation: Bool = false
    @State private var step = 1
    
    var body: some View {
        ZStack {
            Color("onBoardingColor").ignoresSafeArea()
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                
                GeometryReader { geometryProxy in
                    HStack {
                        VStack {
                            Image("gummy-tv-room")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(x: 20, y: 20)
                            Text("室內設計 | 新屋裝潢裝修 | 老屋翻新 | 商業空間")
                                .font(Font.system(size: 16))
                                .padding(.bottom, 10)
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                            Text("喬斯Joe’s提供一個值得信賴、安全、無毒的室內計.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }.frame(width: geometryProxy.frame(in: .global).width)
                        
                        VStack {
                            Image("joesonboarding1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text("Browse your own music library")
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                        }.frame(width: geometryProxy.frame(in: .global).width)
                        
                        VStack {
                            Image("joesonboarding2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text("Browse your own music library")
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                        }.frame(width: geometryProxy.frame(in: .global).width)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .font(Font.body)
                    .frame(width: geometryProxy.frame(in: .global).width * 3) //Make Hstack 3x width of device
                    .frame(maxHeight: .infinity)
                    .offset(x: step == 1 ? 0
                                : step == 2 ? -geometryProxy.frame(in: .global).width
                                : -geometryProxy.frame(in: .global).width * 2)
                    .animation(Animation.interpolatingSpring(stiffness: 50, damping: 8))
                    
                }
                
                HStack(spacing: 20) {
                    Button(action: { self.step = 1 }, label: {
                        Text("1")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().shadow(radius: 5))
                            .scaleEffect(step == 1 ? 1 : 0.65)
                    })
                    
                    Button(action: { self.step = 2 }, label: {
                        Text("2")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().shadow(radius: 5))
                            .scaleEffect(step == 2 ? 1 : 0.65)
                    })
                    
                    Button(action: {self.step = 3 }, label: {
                        Text("3")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().shadow(radius: 5))
                            .scaleEffect(step == 3 ? 1 : 0.65)
                    })
                }
                .animation(.spring(response: 0.4, dampingFraction: 0.5))
                .font(.largeTitle)
                
                
                Button(action: {
                    buttonTapped()
                }, label: {
                    HStack {
                        Text("開始")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding()
                    .background(Capsule())
                    .opacity(step == 3 ? 1 : 0)
                    .animation(.none) //no animation on opacity
                    .scaleEffect(step == 3 ? 1 : 0.01)
                    .animation(Animation.interpolatingSpring(stiffness: 50, damping: 10, initialVelocity: 10))
                    //animation on scale effect
                })
                    .disabled(step == 1 || step == 2)
            }
            .accentColor(Color("JoesGreen"))
            
            SplashScreen(endAnimation: $endAnimation)
        }
        .onAppear {
            endAnimation = true
        }
    }
    
    
    func buttonTapped() {
        print("dismissing..")
        delegate.isDismiss = true
        
    }
    
    func isShowLogoVCToggle() {
        isShowLogoVC.toggle()
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(delegate: ContentViewDelegate())
    }
}

