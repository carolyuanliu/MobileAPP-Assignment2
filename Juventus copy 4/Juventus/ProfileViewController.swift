//
//  ProfileViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 09/03/2021.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

   
    //@IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profileTextView: UITextView!
    
    //var playerData: Player!
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pManagedObject : People!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //teamData = Team(fromXMLFile: "players.xml")
        // Do any additional setup after loading the view.
        
        //nameLabel.text = playerData.name
        profileTextView.isScrollEnabled = true
        profileTextView.text = pManagedObject.statistics
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue3"{
            let destController = segue.destination as!WebViewController
            //pManagedObject = frc.object(at: indexPath!) as? People
            destController.pManagedObject = pManagedObject
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
}
