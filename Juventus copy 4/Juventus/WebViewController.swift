//
//  WebViewController.swift
//  Juventus
//
//  Created by Yuan Liu on 09/03/2021.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController {

    var url:String?
    @IBOutlet weak var WebView: WKWebView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pManagedObject : People!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        WebView.load(URLRequest(url:URL(string:pManagedObject.url!)!))
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
