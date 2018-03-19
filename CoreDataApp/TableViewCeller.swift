//
//  TableViewCeller.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/26/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//

import UIKit


protocol TableViewCellerDelegate
{
    func doAnyAction(cell:TableViewCeller)
}
class TableViewCeller: UITableViewCell {

    @IBOutlet weak var radiobUton: UIButton!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
     var delegate : TableViewCellerDelegate?
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        radiobUton.setTitle("", for: .normal)
         radiobUton.setTitleColor(UIColor.white, for: .normal)
        radiobUton.layer.borderColor = UIColor.gray.cgColor
        radiobUton.layer.borderWidth = 1
        radiobUton.layer.cornerRadius = 13
        
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func radioaction(_ sender: UIButton)
    {
        
      
          delegate?.doAnyAction(cell: self)
    }
    
    
    
    
    
   
}
