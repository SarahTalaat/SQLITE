//
//  UIImageViewExtension.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 27/04/2024.
//

import Foundation
import Kingfisher

extension UIImageView{
    
    func setKFImage(_ imageURL:String , placeholder: String){
        
        self.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: placeholder),options: [.transition(.fade(0.7))], progressBlock: nil)
    }
    

    
}
