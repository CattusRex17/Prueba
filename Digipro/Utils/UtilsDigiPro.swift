//
//  UtilsDigiPro.swift
//  Digipro
//
//  Created by Mauricio Rodriguez on 6/19/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

class UtilsDigiPro: NSObject {
    
    public static func validateRegex(type: RegexType, stringToValidate: String) -> Bool {
        let valid = NSPredicate(format: "SELF MATCHES %@", type.rawValue)
        return valid.evaluate(with: stringToValidate)
    }
}

//Expresiones regulares para correo y teléfono
public enum RegexType: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case phone = "^[0-9]{8,10}$"
}

