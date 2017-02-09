//
//  GroceryTableViewController.swift
//  Grocery List
//
//  Created by Andi Setiyadi on 8/30/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class GroceryTableViewController: UITableViewController {
    
    //var groceries = [String]()
    //var groceries = [NSManagedObject]()
    var groceries = [Grocery]()
    
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        loadData()
    }

    func loadData() {
        //let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Grocery")
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        do {
            let results = try managedObjectContext?.fetch(request)
            groceries = results!
            tableView.reloadData()
        }
        catch {
            fatalError("Error in retrieving Grocery item")
        }
        
        tableView.reloadData()
    }

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Grocery Item", message: "What's to buy now?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField: UITextField) in
            
        }
        
        let addAction = UIAlertAction(title: "ADD", style: UIAlertActionStyle.default) { [weak self] (action: UIAlertAction) in
            /*let textField = alertController.textFields?.first
            
            let entity = NSEntityDescription.entity(forEntityName: "Grocery", in: (self?.managedObjectContext)!)
            
            let grocery = NSManagedObject(entity: entity!, insertInto: self?.managedObjectContext)
            grocery.setValue(textField!.text!, forKey: "item")*/
            
            let itemString: String?
            
            if(alertController.textFields?.first?.text != "") {
                itemString = alertController.textFields?.first?.text
            } else {
                return
            }
            
            let grocery = Grocery(context: (self?.managedObjectContext)!)
            grocery.item = itemString
            
            do {
                try self?.managedObjectContext?.save()
            }
            catch {
                fatalError("Error is storing to data")
            }
            
            self?.loadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.groceries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)

        let grocery = self.groceries[indexPath.row]
        cell.textLabel?.text = grocery.item

        return cell
    }
}
