//
//  DataModel.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 25/04/2024.
//

import Foundation
import UIKit

class DataModel{
    var title: String = ""
    var image: UIImage?
    var rating: Float = 0.0
    var year: Int
    var genere: [String] = []
    
    init(title:String,image:UIImage,rating:Float,year:Int,genere:[String]){
        self.title = title
        self.image = image
        self.rating = rating
        self.year = year
        self.genere = genere
    }
    
    
    
}
