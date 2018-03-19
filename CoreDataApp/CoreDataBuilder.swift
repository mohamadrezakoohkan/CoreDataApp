//
//  CoreDataBuilder.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/26/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataBuilder: UIViewController {
   
    @IBOutlet weak var loadingBar: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    var stepper : Int = 0
   

    @objc func performSeguer(){
        
        performSegue(withIdentifier: "DataStorage_seg", sender: nil)
    }
    @objc func loadingBarExtender(){
  
        stepper = stepper + 10
        
        loadingLabel.text = "Loading \(stepper)%"
        loadingBar.text = loadingBar.text! + "█"
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        loadingLabel.text = "Loading 0%"
        loadingBar.layer.borderWidth = 1.00
        loadingBar.layer.borderColor = UIColor.black.cgColor
        loadingBar.text = ""
        
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.performSeguer), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.loadingBarExtender), userInfo: nil, repeats: true)
        
        
        if isAppAlreadyLaunchedOnce() == true {
            print("DataBase Filled Once")
        }else{
        print("Loading DataBase")
        let appdelegater = UIApplication.shared.delegate as! AppDelegate
        let contexter = appdelegater.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: contexter)
        let User1 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User2 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User3 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User4 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User5 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User6 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User7 = NSManagedObject(entity: entity!, insertInto: contexter)
        let User8 = NSManagedObject(entity: entity!, insertInto: contexter)

        User1.setValue(1, forKey: "id")
        User1.setValue("بدون نام", forKey: "name")
        User1.setValue("۰۹۱۲۵۵۷۷۳۱۳", forKey: "phoneNumber")
        let imageData1 = UIImagePNGRepresentation(UIImage(named:"unknown.png")!)
        User1.setValue(imageData1, forKey: "picture")
        
        User2.setValue(2, forKey: "id")
        User2.setValue("Morteza", forKey: "name")
        User2.setValue("۰۹۳۹۱۲۰۸۷۴۲", forKey: "phoneNumber")
        let imageData2 = UIImagePNGRepresentation(UIImage(named:"boy.png")!)
        User2.setValue(imageData2, forKey: "picture")
        
        
        
        
        
      
        
        
        User3.setValue(3, forKey: "id")
        User3.setValue("علی نیکو", forKey: "name")
        User3.setValue("۰۹۱۹۱۸۳۲۰۱۸", forKey: "phoneNumber")
        let imageData3 = UIImagePNGRepresentation(UIImage(named:"man.png")!)
        User3.setValue(imageData3, forKey: "picture")
        
        User4.setValue(4, forKey: "id")
        User4.setValue("محمدرضا کوهکن", forKey: "name")
        User4.setValue("۰۹۳۹۱۸۴۰۶۸۸", forKey: "phoneNumber")
        let imageData4 = UIImagePNGRepresentation(UIImage(named:"boy.png")!)
        User4.setValue(imageData4, forKey: "picture")
        
        User5.setValue(5, forKey: "id")
        User5.setValue("Nicknaz", forKey: "name")
        User5.setValue("۰۹۳۵۲۰۵۲۰۱۷", forKey: "phoneNumber")
        let imageData5 = UIImagePNGRepresentation(UIImage(named:"girl.png")!)
        User5.setValue(imageData5, forKey: "picture")
        
        User6.setValue(6, forKey: "id")
        User6.setValue("گلناز", forKey: "name")
        User6.setValue("۰۹۱۲۸۴۳۱۲۰۱", forKey: "phoneNumber")
        let imageData6 = UIImagePNGRepresentation(UIImage(named:"girl-4.png")!)
        User6.setValue(imageData6, forKey: "picture")
        
        User7.setValue(7, forKey: "id")
        User7.setValue("گلناز", forKey: "name")
        User7.setValue("۰۹۳۶۹۴۱۸۰۲۲", forKey: "phoneNumber")
        let imageData7 = UIImagePNGRepresentation(UIImage(named:"girl-2.png")!)
        User7.setValue(imageData7, forKey: "picture")
        
        User8.setValue(8, forKey: "id")
        User8.setValue("Shima", forKey: "name")
        User8.setValue("۰۹۱۹۵۵۵۳۲۱۸", forKey: "phoneNumber")
        let imageData8 = UIImagePNGRepresentation(UIImage(named:"girl-3.png")!)
        User8.setValue(imageData8, forKey: "picture")
        
         try! contexter.save()
        //        NSData *imageData = UIImagePNGRepresentation(yourImage);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
  
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }

}
