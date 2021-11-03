//
//  FilterTableViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 25/04/2021.
//

import UIKit
import CoreData

class FilterTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
   var position: String?
    @IBAction func posButton(_ sender: Any) {
        
        let sheet = UIAlertController(title:"Filter Options", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("cancel")
            
        }))
       
        sheet.addAction(UIAlertAction(title: "Goal Keepers", style: .default, handler: { [self](action) -> Void in
        position = "GoalKeeper"
            if position != nil{
                var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
                frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                frc.delegate = self
            do{
                try frc.performFetch()
            }catch{
                print("CD CANNOT FETCH")
            }
                filterPlayer = []
            for i in 0..<frc.sections![0].numberOfObjects{
                
                filterPlayer.append((frc.object(at: [0,i]) as! People))
            }
            }
            tableView.reloadData()
            }))
        sheet.addAction(UIAlertAction(title: "Defenders", style: .default, handler: { [self] (action) -> Void in
        print("Defender")
        position = "Defender"
                if position != nil{
                    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
                    frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                    frc.delegate = self
                do{
                    try frc.performFetch()
                }catch{
                    print("CD CANNOT FETCH")
                }
                    filterPlayer = []
                for i in 0..<frc.sections![0].numberOfObjects{
                    
                    filterPlayer.append((frc.object(at: [0,i]) as! People))
                }
                }
                tableView.reloadData()
                }))
        sheet.addAction(UIAlertAction(title: "Midfielders", style: .default, handler: { [self](action) -> Void in
        position = "Midfielder"
            if position != nil{
                var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
                frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                frc.delegate = self
            do{
                try frc.performFetch()
            }catch{
                print("CD CANNOT FETCH")
            }
                filterPlayer = []
            for i in 0..<frc.sections![0].numberOfObjects{
                
                filterPlayer.append((frc.object(at: [0,i]) as! People))
            }
            }
            tableView.reloadData()
            }))
        sheet.addAction(UIAlertAction(title: "Coach", style: .default, handler: { [self](action) -> Void in
        position = "Coach"
            var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
                frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                frc.delegate = self
            do{
                try frc.performFetch()
            }catch{
                print("CD CANNOT FETCH")
            }
            filterPlayer = []
            for i in 0..<frc.sections![0].numberOfObjects{
               
                filterPlayer.append((frc.object(at: [0,i]) as! People))
            }
            
            tableView.reloadData()
            }))
        
        sheet.addAction(UIAlertAction(title: "Forwards", style: .default, handler: {[self]  (action) -> Void in
            print("Forward")
            self.position = "Forward"
                    if position != nil{
                        var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
                        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                        frc.delegate = self
                    do{
                        try frc.performFetch()
                    }catch{
                        print("CD CANNOT FETCH")
                    }
                        filterPlayer = []
                    for i in 0..<frc.sections![0].numberOfObjects{
                        
                        filterPlayer.append((frc.object(at: [0,i]) as! People))
                    }
                    }
                    tableView.reloadData()
        }))
        self.present(sheet, animated:true, completion:nil)
    }
    
    
    
    
   
    var pEntity : NSEntityDescription! = nil
    var pManagedObject: People!=nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var filterPlayer = [People]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func makeRequest(positionFilter: String? = nil) -> NSFetchRequest<NSFetchRequestResult>{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
       
            let pred = NSPredicate(format:"position == %@", position!)
            request.predicate = pred
      
        // define predicates and sorters
        let sorter = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sorter]
        return request
    }
    


    
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPlayer.count
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
//        pManagedObject = frc.object(at: indexPath) as? People
        cell.textLabel!.text = filterPlayer[indexPath.row].name
        cell.detailTextLabel!.text = filterPlayer[indexPath.row].position
        cell.imageView?.image = UIImage(named: filterPlayer[indexPath.row].image!)
        return cell
    }


    
    // Override to support conditional editing of the table view.
   
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
