//
//  TableViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 08/03/2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchBarDelegate {
    
   
    @IBAction func filterButton(_ sender: Any) {

    }
    
    

    var teamData: Team!

//core data objects functions
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext//access the persistentcontainer to get the ManagedObjectContext
    var pEntity : NSEntityDescription! = nil
    var pManagedObject:People! = nil
    var qManagedObject:Marked!
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    var name: String!
    var positionFilter: String?
    //fetch the data from core data
    func makeRequest(positionFilter: String? = nil) -> NSFetchRequest<NSFetchRequestResult>{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
        if  let positionFilter = positionFilter{
            let pred = NSPredicate(format:"position == %@", positionFilter)
            request.predicate = pred
        }
        // define predicates and sorters
        let sorter = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sorter]
        return request
    }
    
    func makeMarked(){
        // create a marked
        let marked = Marked(context: context)
        
        //create a people
        //var people = People(context: context)
        //add people to marked
        marked.name = pManagedObject.name
        marked.number = pManagedObject.number
        marked.dob = pManagedObject.dob
        marked.nationality = pManagedObject.nationality
        marked.position = pManagedObject.position
        marked.statistics = pManagedObject.statistics
        marked.image = pManagedObject.image
        marked.url = pManagedObject.url
        
        //save context
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
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //teamData gets the data from XML
        teamData = Team(fromXMLFile: "players.xml")
      
        //frc gets the data from Player
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext:context, sectionNameKeyPath:nil, cacheName:nil)
        
        
        frc.delegate = self
        do{
            try frc.performFetch()
        }catch{
            print ("CD CANNOT FETCH")
        }
        
        
        if let fetchObj = frc.fetchedObjects, fetchObj.isEmpty{
            
            // get the data from teamData to managedObject
            for i in 0..<teamData.getCount() {
                pManagedObject = People(context:context)
                pManagedObject.name = teamData.getPlayer(index: i).name
                pManagedObject.number = teamData.getPlayer(index: i).number
                pManagedObject.position = teamData.getPlayer(index: i).position
                pManagedObject.nationality = teamData.getPlayer(index: i).nationality
                pManagedObject.dob = teamData.getPlayer(index: i).dateOfBirth
                pManagedObject.image = teamData.getPlayer(index: i).image
                pManagedObject.statistics = teamData.getPlayer(index: i).profile
                pManagedObject.url = teamData.getPlayer(index: i).url
                
                do { try context.save() }
               catch { print("Core Data Does Not Save") }
            }
        }
        
    }
    
    func controllerDidChangeContent(_controller: NSFetchedResultsController<NSFetchRequestResult>){
                tableView.reloadData()
    }
    
// func reloadData(positionFilter:String? = nil){
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "People")
//        if let positionFilter = positionFilter{
//            let pred = NSPredicate(format: "position == %@", positionFilter)
//            fetchRequest.predicate = pred
//        frc = NSFetchedResultsController(fetchRequest: makeRequest(positionFilter: positionFilter), managedObjectContext:context, sectionNameKeyPath:nil, cacheName:nil)
//
//            tableView.reloadData()
//        }
//
//        do { try context.save() }
//
//        catch { print("Core Data Does Not Save") }
//        tableView.reloadData()
//    }
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
        pManagedObject = frc.object(at: indexPath) as? People
        qManagedObject = frc.object(at: indexPath) as? Marked
        
        cell.textLabel!.text = pManagedObject.name
        cell.detailTextLabel!.text = pManagedObject.position
        cell.imageView?.image = UIImage(named: pManagedObject.image!)
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support edidting the table view.
    override func tableView(_ tableView:UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt  indexPath:IndexPath){
        if editingStyle == .delete{
           
            //Delete the row from the data source
            pManagedObject = (frc.object(at:indexPath) as!People)
            if (pManagedObject.image != nil) 
            {
            deleteImage(name: pManagedObject.image!)
            }
            context.delete(pManagedObject)
            
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



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue1"{
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            pManagedObject = frc.object(at: indexPath!) as? People
            let destController = segue.destination as!PlayerViewController
            destController.pManagedObject = pManagedObject
        }
        else if segue.identifier == "addSegue"{
            // get the data from frc of indexPath
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var pEntity : NSEntityDescription!
            // create a new managed object
            pEntity = NSEntityDescription.entity(forEntityName: "People", in: context)
            pManagedObject = People(entity: pEntity, insertInto: context)
            
            // push to AddPlayerviewController
            let destination = segue.destination as? addPlayerViewController
            destination?.pManagedObject = pManagedObject
            }
        else if segue.identifier == "filterSegue"{
            let destination = segue.destination as? FilterTableViewController
            destination?.pManagedObject = pManagedObject
        }
    }
    // functions to work with images
    func getImage(name:String)-> UIImage!{
       //get the absolute path to the image in documents
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent(name)
        
        return UIImage(contentsOfFile: filePath)
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

   
    
//    func fetchSearched(sText:String) -> [People]{
//        var sData = [People]()
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let pred = NSPredicate(format: "position CONTAINS %@", sText)
//        let request:NSFetchRequest =  People.fetchRequest()
//        request.predicate = pred
//        do {
//            sData = try (context.fetch(request))
//        } catch  {
//            print("ERROR WHILE SEARCH")
//        }
//        return sData
//    }
    
    

 }

