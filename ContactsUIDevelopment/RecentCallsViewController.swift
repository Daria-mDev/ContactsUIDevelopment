//
//  RecentCallsViewController.swift
//  ContactsUIDevelopment
//
//  Created by user on 22.03.2021.
//

import UIKit
import CoreData

class RecentCallsViewController: UIViewController {
    
    @IBOutlet var recentCallsTableView: UITableView!
    
    var calls: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentCallsTableView.delegate = self
        recentCallsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetch()
    }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"RecentCalls")
        do {
            calls = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            calls.reverse()
            recentCallsTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch data: \(error)")
        }
    }
}

extension RecentCallsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callsCell", for: indexPath) as! CallsTableViewCell
        let call = calls[indexPath.row]
        cell.contactLabel.text = call.value(forKeyPath: "name") as? String
        cell.callTimeLabel.text = call.value(forKeyPath: "time") as? String
        return cell
    }
}
