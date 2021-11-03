//
//  PlayerViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 08/03/2021.
//

import UIKit
import CoreData

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var playerPositionLabel: UILabel!
    
    @IBOutlet weak var playerDateOfBirthLabel: UILabel!
    
    @IBOutlet weak var playerNationalityLabel: UILabel!
    
    @IBOutlet weak var playerNumberLabel: UILabel!
    
    @IBAction func printButtton(_ sender: Any) {
        print(pManagedObject.statistics!)
    }
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    var pEntity : NSEntityDescription! = nil
    
   
    
    
   
   
   
    @IBAction func markButton(_ sender: Any) {
        markedSave()
    }
    
    var pManagedObject: People!
    var qManagedObject: Marked!
    
    //save data to Marked entity
    func markedSave(){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var qEntity : NSEntityDescription!
            // create a new managed object
            qEntity = NSEntityDescription.entity(forEntityName: "Marked", in: context)
            qManagedObject = Marked(entity: qEntity, insertInto: context)
            //update managed object with text from fields
            qManagedObject.name = pManagedObject.name
            qManagedObject.number = pManagedObject.number
            qManagedObject.position = pManagedObject.position
            qManagedObject.dob = pManagedObject.dob
            qManagedObject.nationality = pManagedObject.nationality
            qManagedObject.url = pManagedObject.url
            qManagedObject.statistics = pManagedObject.statistics
            qManagedObject.image = pManagedObject.image
            
            // save
            do{
                try context.save()
            }catch{
                print("CD CANNOT SAVE")
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //var pEntity : NSEntityDescription!
        // create a new managed object
       
        pEntity = NSEntityDescription.entity(forEntityName: "People", in: context)
        
        //pManagedObject = People(entity: pEntity, insertInto: context)
        if pManagedObject != nil{
        playerNameLabel.text = pManagedObject.name
        playerImageView.image = UIImage(named: pManagedObject.image!)
        playerPositionLabel.text = pManagedObject.position
        playerNationalityLabel.text = pManagedObject.nationality
        playerDateOfBirthLabel.text = pManagedObject.dob
        playerNumberLabel.text = pManagedObject.number
        }
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "segue2"{
           
            let destController = segue.destination as!ProfileViewController
            destController.pManagedObject = self.pManagedObject
        }
        else if segue.identifier == "editSegue"{
           
            
            // push to AddPlayerviewController
            let destController = segue.destination as!addPlayerViewController
            destController.pManagedObject = self.pManagedObject
            
            
            
        }
        
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
