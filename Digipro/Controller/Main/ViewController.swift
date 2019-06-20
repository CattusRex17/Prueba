//
//  ViewController.swift
//  Digipro
//
//  Created by Mauricio Rodriguez on 6/19/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

class InitialForm: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Alerta
    func alert(title: String, mesaje: String){
        let alert = UIAlertController(title: title, message: mesaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //Método para validar campos
    func validations() -> Persona? {
        
        guard let name = nameTextField?.text else { return nil}
        guard let surname = surnameTextField?.text else { return nil}
        guard let lastname = lastnameTextField?.text else { return nil}
        guard let email = emailTextField?.text else { return nil }
        guard let phone = phoneTextField?.text else { return nil}
        
        
        if name.isEmpty || name.count > 50  {
            alert(title: "Error", mesaje: "Verifica el campo nombre")
            return nil
        } else if surname.isEmpty || surname.count > 30  {
            alert(title: "Error", mesaje: "Verifica el campo apellido paterno")
            return nil
            
        } else if lastname.isEmpty || lastname.count > 30  {
            alert(title: "Error", mesaje: "Verifica el campo apellido materno")
            return nil
            
        } else if email.isEmpty || !validateRegex(.email, email){
            alert(title: "Error", mesaje: "Verifica el campo email")
            return nil
            
        } else if phone.isEmpty || !validateRegex(.phone, phone){
            alert(title: "Error", mesaje: "Verifica el campo telefono")
            return nil
            
        } else {
            let created = Persona()
            created.name = name
            created.surname = surname
            created.lastname = lastname
            created.email = email
            created.phone = phone
            
            return created
        }
    }
    
    //Método que llama a funcion regex
    func validateRegex(_ type: RegexType, _ stringToValidate: String) -> Bool {
        return  UtilsDigiPro.validateRegex(type: type, stringToValidate: stringToValidate)
    }
    
    
    
    //Método para tabular de un campo a otro
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case nameTextField:
            surnameTextField?.becomeFirstResponder()
        case surnameTextField:
            lastnameTextField?.becomeFirstResponder()
        case lastnameTextField:
            emailTextField?.becomeFirstResponder()
        case emailTextField:
            phoneTextField?.becomeFirstResponder()
        default:
            phoneTextField?.resignFirstResponder()
        }
        return true
    }
    
    //Método para botón
    
    @IBAction func registerButton(_ sender: Any) {
        almacenarDatos()
        clearTextFields()
    }
    
    func almacenarDatos() {
        var personasGuardadas = Personas()
        
        if let validation = validations() {
            if Persistance.getPerson().personas.count == 0 {
                Persistance.savePerson(person: validation)
            }
            Persistance.addPerson(person: validation)
        }
        
        personasGuardadas = Persistance.getPerson()
        
        for itemPersona in personasGuardadas.personas {
            print(itemPersona.email)
        }
    }
    
    func clearTextFields() {
        self.emailTextField.text = ""
        self.nameTextField.text = ""
        self.surnameTextField.text = ""
        self.lastnameTextField.text = ""
        self.phoneTextField.text = ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == phoneTextField {
            guard let text = phoneTextField?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        return true
    }
    
}


