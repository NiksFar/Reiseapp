//
//  Errors.swift
//  Reiseapp
//
//  Created by Mykyta on 15.09.26.
//
import Foundation

enum LoginError: Error {
    case invalidEmail, authorizationFailed
    
    var message: String {
        switch self {
        case .invalidEmail: "Bitte tragen Sie eine gültige E-Mail ein."
        case .authorizationFailed: "Login fehlgeschlagen. Bitte überprüfen Sie die E-Mail oder das Passwort"
        }
    }
}

struct InputError: Error {
    let fieldName: String

    var message: String {
        switch fieldName {
        case "E-mail":
            "E-Mail darf nicht leer sein."
        case "Passwort":
            "Passwort darf nicht leer sein."
        default:
            "Dieses Feld darf nicht leer sein."
        }
    }
}
    

