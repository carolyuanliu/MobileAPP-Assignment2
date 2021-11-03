//
//  addPlayerViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 06/04/2021.
//

import UIKit
import CoreData

class addPlayerViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var numberTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var positionTF: UITextField!
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var dobTF: UITextField!
    
    @IBOutlet weak var naTF: UITextField!
    @IBOutlet weak var urlTF: UITextField!
    
    @IBOutlet weak var statisticsTV: UITextView!
    
    @IBOutlet weak var imageTF: UITextField!
    
    @IBOutlet weak var pickImageView: UIImageView!
    
    
    @IBAction func pickAction(_ sender: Any) {
        // setup imagePicker
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
                
        // present it
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func clearAction(_ sender: Any) {
        
        nameTF.text = nil
        numberTF.text = nil
        positionTF.text = nil
        dobTF.text = nil
        naTF.text = nil
        urlTF.text = nil
        statisticsTV.text = nil
        imageTF.text = nil
   
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        if pManagedObject == nil{(save())}
        else{update()}
        
        navigationController?.popViewController(animated: true)
    }
    
    //core data objects
    

    
    var pManagedObject : People!
    override func viewDidLoad() {
        super.viewDidLoad()
//       
      if pManagedObject != nil {
            nameTF.text       = pManagedObject.name
            numberTF.text     = pManagedObject.number
            positionTF.text   = pManagedObject.position
            dobTF.text        = pManagedObject.dob
            naTF.text         = pManagedObject.nationality
            urlTF.text        = pManagedObject.url
            statisticsTV.text = pManagedObject.statistics
            imageTF.text      = pManagedObject.image
           if imageTF.text != nil{
                getImage(name: imageTF.text!)
           }
      }
    }
    
    func update(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //update managed object with text from fields
        pManagedObject.name = nameTF.text
        pManagedObject.number = numberTF.text
        pManagedObject.position = positionTF.text
        pManagedObject.dob = dobTF.text
        pManagedObject.nationality = naTF.text
        pManagedObject.url = urlTF.text
        pManagedObject.statistics = statisticsTV.text
        pManagedObject.image = imageTF.text
        
        // save
        do{
            try context.save()
        }catch{
            print("CD CANNOT SAVE")
        }
    }
    
    func save(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var pEntity : NSEntityDescription!
        // create a new managed object
        pEntity = NSEntityDescription.entity(forEntityName: "People", in: context)
        pManagedObject = People(entity: pEntity, insertInto: context)
        
        //update managed object with text from fields
        pManagedObject.name = nameTF.text
        pManagedObject.number = numberTF.text
        pManagedObject.position = positionTF.text
        pManagedObject.dob = dobTF.text
        pManagedObject.nationality = naTF.text
        pManagedObject.url = urlTF.text
        pManagedObject.statistics = statisticsTV.text
        pManagedObject.image = imageTF.text
        
        // save
        do{
            try context.save()
        }catch{
            print("CD CANNOT SAVE")
        }
    }
    
    //function to work with images
    func getImage(name:String){
       //get the absolute path to the image in documents
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent(name)
        //make an uiimage
        let image = UIImage(contentsOfFile: filePath)
        
        //place it to imageview
        pickImageView.image = image
        
    }
    func putImage(name:String){//save the image from imageview to document
        //file manager
        let fm = FileManager.default
        
        //get the path to where you want to save
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent(name)
        
        //get the image data
        let image = pickImageView.image
        let imageData = image?.pngData()
        
        //fm to create the file
        fm.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
    }
    
    let imagePicker = UIImagePickerController()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // if we cancel picking
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // picked an image and place it in info
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //place it to imageview
        pickImageView.image = image
        
        //dismiss
       //dismiss(animated: true, completion: nil)
        
    }
    }



