//
//  JSSearchView.swift
//  CoreDataApp
//
//  Created by Mohammad reza Koohkan on 12/26/1396 AP.
//  Copyright © 1396 AP Mohammad reza Koohkan. All rights reserved.
//

import UIKit

class JSSearchView: UIView {

    class JSSearchView : UIView {
        
        var searchBar : UISearchBar!
        
        override func awakeFromNib()
        {
            self.searchBar = UISearchBar(frame: self.frame)
            
            self.searchBar.clipsToBounds = true
            
            self.searchBar.layer.cornerRadius = 5
            
            self.addSubview(self.searchBar)
            
            self.searchBar.translatesAutoresizingMaskIntoConstraints = false
            
            let leadingConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
            let trailingConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
            let yConstraint = NSLayoutConstraint(item: self.searchBar, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            
            self.addConstraints([yConstraint, leadingConstraint, trailingConstraint])
            
            self.searchBar.backgroundColor = UIColor.clear
            self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            self.searchBar.tintColor = UIColor.clear
            self.searchBar.isTranslucent = true
            
                        for s in self.searchBar.subviews[0].subviews {
                if s is UITextField {
                    s.layer.borderWidth = 1.0
                    s.layer.cornerRadius = 10
                    s.layer.borderColor = UIColor.green.cgColor
                }
            }
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
                        let topRect = CGRect(origin: .zero, size: CGSize(width: self.frame.size.width, height: (self.frame.height / 2)))
            UIColor.green.set()
            UIRectFill(topRect)
        }
    }

}
