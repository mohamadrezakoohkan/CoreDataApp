//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/25/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//

import UIKit
import CoreData

extension UISearchBar {
    var textField:UITextField {
        guard let txtField = self.value(forKey: "_searchField") as? UITextField else {
            assertionFailure()
            return UITextField()
        }
        return txtField
    }
}


class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource,TableViewCellerDelegate,UICollectionViewDelegate,UICollectionViewDataSource ,UISearchBarDelegate,UISearchDisplayDelegate{


    
    

   
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var ColectView: UICollectionView!
    @IBOutlet weak var tableviewer: UITableView!
    @IBOutlet weak var searchBarOnView: UISearchBar!
    @IBOutlet weak var searchBarOnViewPlaceHolder: UILabel!
    
    @IBOutlet weak var navigationBarOnView: UINavigationItem!
    
  //  var senderToNextActivity = [User]()
    var user = [User]()
    var selecteduser = [User]()
    var count = 0
    var foundUsers:[User] = []
    let placeholderWidth = 200
    var offset = UIOffset()
    var phoneNumbers : [String] = []
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
   
        let customTitle = UILabel()
        customTitle.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        customTitle.center = CGPoint(x: 0, y: 0)
        customTitle.textAlignment = .center
        customTitle.text = "افزودن اعضا"
        customTitle.shadowColor = UIColor.black
        customTitle.layer.shadowRadius = 9
       customTitle.layer.shadowColor = UIColor.black.cgColor
        customTitle.layer.shadowOpacity = 1.00
        customTitle.textColor = UIColor.white
        self.navigationBarOnView.titleView = customTitle
        

        self.navigationController?.isNavigationBarHidden = false
       
        self.tableviewer.allowsSelection = false
     
        fetching()
        
        searchBarOnView.textField.layer.cornerRadius = 17

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftViewMode = .never
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(displayP3Red: 230/255, green: 229/255, blue: 234/255, alpha: 1)
     UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).layer.borderColor = UIColor.red.cgColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).clipsToBounds = true
  
        searchBarOnView.textField.clearButtonMode = .never
    }

    func fetching()
    {
        
        let appdelegater = UIApplication.shared.delegate as! AppDelegate
        let contexter = appdelegater.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
      
        
        //   let request: NSFetchRequest<User> = User.fetchRequest()
        
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
      
        
       let _user = try! contexter.fetch(request) as! [User]
       user=_user.sorted(){$0.id<$1.id}
        
        
        
       
        
      
    }
    

    
    
/////////////////////////////////// Table View ////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCeller = self.tableviewer.dequeueReusableCell( withIdentifier: "Tcell", for: indexPath) as! TableViewCeller
       
      cell.delegate = self
        cell.radiobUton.tag = Int(user[indexPath.row].id)
       cell.name.text=user[indexPath.row].name
       cell.number.text=user[indexPath.row].phoneNumber
     
    
        
        cell.radiobUton.isSelected=user[indexPath.row].flag
     
              if  cell.radiobUton.isSelected==true
            {
                cell.radiobUton.setTitle("✓", for: .normal)
                cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
                cell.radiobUton.layer.backgroundColor = UIColor(displayP3Red: 94/255, green: 197/255, blue: 84/255, alpha: 1).cgColor
            }
            else
            {
                cell.radiobUton.setTitle("", for: .normal)
                cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
                cell.radiobUton.layer.backgroundColor = UIColor.white.cgColor
            }
        
        
        
        
        if let imgdata = user[indexPath.row].picture
        {
            if let image = UIImage(data:imgdata as Data)
            {
               cell.pic.image=image
            }
        }
       
         return cell
    }
  
    func doAnyAction(cell: TableViewCeller)
    {
        cell.radiobUton.adjustsImageWhenHighlighted = true
        
        if  cell.radiobUton.isSelected==true
        {
            
            let found = selecteduser.index(where: {$0.id==cell.radiobUton.tag})
            let found2 = user.index(where: {$0.id==cell.radiobUton.tag})
            user[found2!].flag=false
            selecteduser.remove(at:found!)
            
            //        cell.radiobUton.isSelected=false
            //        cell.radiobUton.setTitle("", for: .normal)
            //        cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
            //        cell.radiobUton.layer.backgroundColor = UIColor.white.cgColor
        }
        else
        {
            let found = user.index(where: {$0.id==cell.radiobUton.tag})
            user[found!].flag=true
            selecteduser.append(user[found!])
            
            //             cell.radiobUton.isSelected=true
            //             cell.radiobUton.setTitle("✓", for: .normal)
            //             cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
            //             cell.radiobUton.layer.backgroundColor = UIColor(displayP3Red: 94/255, green: 197/255, blue: 84/255, alpha: 1).cgColor
        }
        
        
        ColectView.reloadData()
        tableviewer.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return user.count
    }
    
    
    
    
 //////////////////////////////////////// Collection View //////////////////////////////////////////////
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell: CollectionViewCeller=collectionView.dequeueReusableCell(withReuseIdentifier: "Ccell", for: indexPath) as! CollectionViewCeller
        cell.colectext.text=selecteduser[indexPath.row].name
         cell.tag = Int(selecteduser[indexPath.row].id)
        if let imgdata = selecteduser[indexPath.row].picture
        {
            if let img = UIImage(data:imgdata as Data)
            {
              cell.userImage.image=img
            }
        }

    return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {

        
        return selecteduser.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
//       let activitySender = user.index(where: {$0.phoneNumber==user[indexPath.row].phoneNumber})
     
       
     
        
        let found1 = selecteduser.index(where: {$0.id==selecteduser[indexPath.row].id})
        let found2 = user.index(where: {$0.id==selecteduser[indexPath.row].id})
         user[found2!].flag=false
     
        selecteduser.remove(at:found1!)

        ColectView.reloadData()
       
      
        tableviewer.reloadData()
        
    }
  
    
   
    ////////////////////////////// Search Bar ///////////////////
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarOnViewPlaceHolder.isHidden = false
        view.endEditing(true)
    }
        
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarOnViewPlaceHolder.isHidden = true
    }
    
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        view.endEditing(true)
//        return true
//    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if !searchText.isEmpty  {
            
            var predicateNumber: NSPredicate = NSPredicate()
            predicateNumber = NSPredicate(format: "phoneNumber contains[c] '\(searchText)'")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let contexter = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
            fetchRequest.predicate = predicateNumber
            do {
                user = try contexter.fetch(fetchRequest)  as! [User]
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
           
        }

        
        if searchBar.text == nil || searchBar.text == ""
        {
            searchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
            tableviewer.reloadData()
        }
        if searchBar.text == ""
        {
            tableviewer.reloadData()
        }
        tableviewer.reloadData()
    }
    
    //         if !searchText.isEmpty {
    //            var predicateName: NSPredicate = NSPredicate()
    //            predicateName = NSPredicate(format: "name contains[c] '\(searchText)'")
    //            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    //            let contexter = appDelegate.persistentContainer.viewContext
    //            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
    //            fetchRequest.predicate = predicateName
    //            do {
    //                user = try contexter.fetch(fetchRequest)  as! [User]
    //            } catch let error as NSError {
    //                print("Could not fetch. \(error)")
    //            }
    //        }
   
    @IBAction func sendToNextActivity(_ sender: UIBarButtonItem) {
        
        for _user in selecteduser
        {
            phoneNumbers.append(_user.phoneNumber!)
        }
        print(phoneNumbers)
       
     
    } 
 
    
   
//    func doAnyAction(cell: TableViewCeller)
//    {
//        cell.radiobUton.adjustsImageWhenHighlighted = true
//
//        if  cell.radiobUton.isSelected==true
//        {
//            cell
//
//            let found = selecteduser.index(where: {$0.id==cell.radiobUton.tag})
//            let found2 = user.index(where: {$0.id==cell.radiobUton.tag})
//            user[found2!].flag=false
//            selecteduser.remove(at:found!)
//
//            //        cell.radiobUton.isSelected=false
//            //        cell.radiobUton.setTitle("", for: .normal)
//            //        cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
//            //        cell.radiobUton.layer.backgroundColor = UIColor.white.cgColor
//        }
//        else
//        {
//            let found = user.index(where: {$0.id==cell.radiobUton.tag})
//            user[found!].flag=true
//            selecteduser.append(user[found!])
//
//            //             cell.radiobUton.isSelected=true
//            //             cell.radiobUton.setTitle("✓", for: .normal)
//            //             cell.radiobUton.setTitleColor(UIColor.white, for: .normal)
//            //             cell.radiobUton.layer.backgroundColor = UIColor(displayP3Red: 94/255, green: 197/255, blue: 84/255, alpha: 1).cgColor
//        }
//
//
//        ColectView.reloadData()
//        tableviewer.reloadData()
//    }
//
//
    
    
}

