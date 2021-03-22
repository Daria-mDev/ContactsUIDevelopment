//
//  AddContactViewController.swift
//  ContactsUIDevelopment
//
//  Created by user on 21.03.2021.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
    var contact: NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = self.contact {
            nameTextField.text = contact.value(forKey: "name") as? String
            phoneTextField.text = contact.value(forKey: "phoneNumber") as? String
        }
    }
    
    @IBAction func saveContact(_ sender: Any) {
        performSegue(withIdentifier: "unwindToContacts", sender: self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
