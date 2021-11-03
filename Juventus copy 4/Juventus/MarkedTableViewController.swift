//
//  MarkedTableViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 24/04/2021.
//

import UIKit
import CoreData

class MarkedTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    var qEntity : NSEntityDescription! = nil
    var qManagedObject: Marked!
    var pManagedObject: People!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
        func makeRequest() -> NSFetchRequest<NSFetchRequestResult>{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Marked")
            // define predicates and sorters
            let sorter = NSSortDescriptor(key: "position", ascending: true)
            request.sortDescriptors = [sorter]
            return request
        }
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext:context, sectionNameKeyPath:nil, cacheName:nil)
            
            
            frc.delegate = self
            do{
                try frc.performFetch()
            }catch{
                print ("CD CANNOT FETCH")
            }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        // Configure the cell...
        
        qManagedObject = frc.object(at: indexPath) as? Marked
        
        cell.textLabel!.text = qManagedObject.name
        cell.detailTextLabel!.text = qManagedObject.position
        cell.imageView?.image = UIImage(named: qManagedObject.image!)
        return cell

    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            qManagedObject = (frc.object(at:indexPath) as!Marked)
            
            deleteImage(name: qManagedObject.image!)
            context.delete(qManagedObject)
            
            do{
                try context.save()
            }catch{
                print("CD CONTEXT CANNOT SAVE")
            }
            do {
                try frc.performFetch()
            } catch  {
                print("CD CANNOT FETCH")
            }
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        qManagedObject = frc.object(at: indexPath!) as? Marked
        
        if segue.identifier == "markedDetail"{
            let destController = segue.destination as!PlayerViewController
            
        // Pass the selected object to the new view controller.
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var pEntity : NSEntityDescription!
            // create a new managed object
           
            pEntity = NSEntityDescription.entity(forEntityName: "People", in: context)
            pManagedObject = People(entity: pEntity, insertInto: context)
            
            //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            pManagedObject.name = qManagedObject.name
            pManagedObject.number = qManagedObject.number
            pManagedObject.position  = qManagedObject.position
            pManagedObject.dob = qManagedObject.dob
            pManagedObject.url = qManagedObject.url
            pManagedObject.statistics = qManagedObject.statistics
            pManagedObject.image = qManagedObject.image
            // save
            do{
                try context.save()
            }catch{
                print("CD CANNOT SAVE")
            }
            destController.pManagedObject = pManagedObject
            
           
            }
        }
    }
    // a function to deleteImage(name:Tring)
    func deleteImage(name:String){
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent(name)
        
       //get fileManager
        let fm = FileManager.default
        
        //delete
        do{
            try fm.removeItem(atPath: filePath)
        }catch{
            
        }
    }



