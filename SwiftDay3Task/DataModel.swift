//
//  DataModel.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 25/04/2024.
//

import Foundation

class DataModel{
    var title: String = ""
    var image: String = ""
    var rating: Float = 0.0
    var year: Int
    var genere: [String] = []
    
    init(title:String,image:String,rating:Float,year:Int,genere:[String]){
        self.title = title
        self.image = image
        self.rating = rating
        self.year = year
        self.genere = genere
    }
    
    
    
}
