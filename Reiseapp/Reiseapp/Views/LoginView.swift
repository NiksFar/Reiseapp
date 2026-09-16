//
//  LoginView.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//

import SwiftUI

struct LoginView: View {
    
    @Bindable var loginViewModel: LoginViewModel
    @State private var isSecure = true
    
    
    var body: some View {

            ZStack {
                AppBackgroundView()
                
                VStack(spacing: 60) {
                    
                    Image(systemName: "suitcase.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.iconBG)
                    
                    VStack(spacing: 18) {
                        TextField("E-mail", text: $loginViewModel.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            if isSecure {
                                SecureField("Passwort", text: $loginViewModel.password)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .padding()
                            } else {
                                TextField("Passwort", text: $loginViewModel.password)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .padding()
                            }
                            
                            Button {
                                isSecure.toggle()
                            } label: {
                                Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill" )
                                    .padding()
                            }
                            
                        }
                        .frame(height: 50)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        if let error = loginViewModel.errorMessage {
                            Text(error)
                                .font(.headline)
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center, spacing: 15) {
                        
                        Button {
                            loginViewModel.logIn()
                        } label: {
                            Text("Einloggen")
                        }
                        .padding()
                        .frame(width: 150)
                        .background(.yellow)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
                        
                        Button {
                            //
                        } label: {
                            Text("Registrieren")
                        }
                        .padding()
                        .frame(width: 150)
                        .background(.loginButtons)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
                        
                    }
                }
            }

        }
    }


#Preview {
    LoginView(loginViewModel: LoginViewModel())
}
