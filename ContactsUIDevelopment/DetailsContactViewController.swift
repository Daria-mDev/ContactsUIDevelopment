//
//  DetailsContactViewController.swift
//  ContactsUIDevelopment
//
//  Created by user on 22.03.2021.
//

import UIKit
import CoreData

enum EditStatus {
    case edit
    case done
    
    public func description() -> String {
        switch self {
        case .edit:
            return "Edit"
        case .done:
            return "Done"
        }
    }
}


class DetailsContactViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var callBtn: UIButton!
    
    var contact: NSManagedObject? = nil
    var isDeleted: Bool = false
    
    private var inEditMode: Bool = false
    
    var indexPathForContact: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
                nameTextField.text = contact?.value(forKey:"name") as? String
                phoneTextField.text = contact?.value(forKey:"phoneNumber") as? String
                
                setEnabled()


        // Do any additional setup after loading the view.
    }
    

    @IBAction func makeCall(_ sender: Any) {
        guard let name: String = nameTextField.text, let url = URL(string: "tel://\(phoneTextField.text!)"),
                     UIApplication.shared.canOpenURL(url) else {return}
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
               saveCall(contactName: name, callTime: getCallTime())
    }
    @IBAction func deleteContact(_ sender: Any) {
        isDeleted = true
                performSegue(withIdentifier: "unwindToContacts", sender: self)

    }
    @IBAction func editContact(_ sender: Any) {
        if editBtn.titleLabel?.text == EditStatus.edit.description() {
                   inEditMode = true
                   editBtn.setTitle(EditStatus.done.description(), for: .normal)
               } else {
                   inEditMode = false
                   editBtn.setTitle(EditStatus.edit.description(), for: .normal)
                   performSegue(withIdentifier: "unwindToContacts", sender: self)
               }
               setEnabled()

    }
    
    private func setEnabled() {
           nameTextField.isUserInteractionEnabled = inEditMode
           phoneTextField.isUserInteractionEnabled = inEditMode
           deleteBtn.isEnabled = inEditMode
           deleteBtn.isHidden = !inEditMode
       }
    
    func saveCall(contactName name: String,callTime time: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
               let managedObjectContext = appDelegate.persistentContainer.viewContext
               guard let entity = NSEntityDescription.entity(forEntityName: "RecentCalls", in: managedObjectContext) else { return }
           
               let recentCall = NSManagedObject(entity: entity, insertInto: managedObjectContext)
               recentCall.setValue(name, forKeyPath: "name")
               recentCall.setValue(time, forKeyPath: "time")
               do {
                   try managedObjectContext.save()
               } catch let error as NSError{
                   print("Couldn't save data: \(error)")
               }

    }
    func getCallTime() -> String {
            let today = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            return formatter.string(from: today)
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
