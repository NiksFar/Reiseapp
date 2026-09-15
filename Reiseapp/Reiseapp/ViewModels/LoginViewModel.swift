//
//  LoginViewModel.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//
import Observation
import Foundation

@Observable
class LoginViewModel {
    
    var email = ""
    var password = ""
    var errorMessage: String?
    let user = User()
    
    private func validateInput() throws {
        guard !email.isEmpty else {
            throw InputError(fieldName: "E-mail")
        }
        guard !password.isEmpty else {
            throw InputError(fieldName: "Passwort")
        }
    }
    
    func logIn() {
        errorMessage = nil
        do {
            try validateInput()
            if email == user.email && password == user.password {
                // next view
            } else {
                throw LoginError.authorizationFailed
            }
        } catch let error as InputError {
            errorMessage = error.message
        } catch let error as LoginError {
            errorMessage = error.message
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
