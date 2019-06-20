//
//  Persistance.swift
//  Digipro
//
//  Created by Mauricio Rodriguez on 6/19/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit
import RealmSwift

class Persistance: NSObject {

    
    //Método para guardar persona
    public static func savePerson(person: Persona) {
        var userData = Personas()
        userData.personas.append(person)

        do {
            let realm = try Realm()
            do {
                try realm.write { realm.add(userData) }
            } catch let error as NSError {
                print("\(error.localizedDescription)")
            }
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    
    //Método para agregar persona
    public static func addPerson(person: Persona) {
        var userData = Personas()
        do {
            let realm = try Realm()
            var usersData = realm.objects(Personas.self)
            do {
                try realm.write { usersData.first?.personas.append(person) }
            } catch let error as NSError {
                print("\(error.localizedDescription)")
            }
        } catch {
            print("No se puede iniciar realm")
        }
    }
    
    //Método para traer persona
    public static func getPerson() -> Personas {
        var userData = Personas()
        do {
            let realm = try Realm()
            let usersData = realm.objects(Personas.self)
            guard let personasRecibidas = usersData.first else { return Personas() }
            userData = personasRecibidas
        } catch {
            print("No se puede iniciar realm")
        }
        return userData
    }

}


//Objeto en realm para persona
public class Personas: Object {
    var personas = List<Persona>()
}

public class Persona: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
}
