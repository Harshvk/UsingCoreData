import Foundation
import CoreData
import UIKit

class DBHelper   {
    
    //MARK: Variables
    /*--------------*/
    var people = [Person]()
    
    var name : String
    
    var email : String
    
    var phone : Int64
    
    var age : Int64
    
    //MARK: Initializers
    /*----------------*/
    init() {
        
        name = ""
        
        phone = 0
        
        email = ""
        
        age = 0
        
    }
    
    init(withName name : String , withAge age : Int64 , withEmail email : String , withPhone phone : Int64) {
        
        self.name = name
        
        self.age = age
        
        self.email = email
        
        self.phone = phone
    }
    
}

extension DBHelper {
    
    //MARK: SaveData Method
    /*--------------------*/
    func saveData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person" , in: managedContext)!
        
        let person = Person(entity: entity , insertInto: managedContext)
        
        person.name = name
        
        person.age = age
  
        person.phone = phone
        
        person.email = email
        

        
        do {
            
            try managedContext.save()
            
            people.append(person)
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
    }
    
    //MARK: getData Method
    /*------------------*/
    func getData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            
            people = try managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
    }
    
    //MARK: deleteData Method
    /*---------------------*/
    func deleteData(_ deleteSpecificData : Person) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(deleteSpecificData)
        
        do {
            
            try managedContext.save()
            
        }
        catch _ {
            
        }
        
    }
    
    //MARK: editAtPerson Method
    /*------------------------*/
    func editAtPerson(_ atPerson : Person , _ personIndex : Int)		{
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            fatalError("no Delegate !")
            
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            
            people = try managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        people[personIndex].name = atPerson.name
        
        people[personIndex].email = atPerson.email
        
        people[personIndex].age =	atPerson.age
        
        people[personIndex].phone = atPerson.phone
        
        do{
            
            try managedContext.save()
            
            print("saved")
            
        }catch let error as NSError {
            
            print("Could not save \(error)")
            
        }
        
    }
    
}
