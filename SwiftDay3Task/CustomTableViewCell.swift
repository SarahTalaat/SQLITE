//
//  CustomTableViewCell.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 27/04/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var customImage: UIImageView!
    
    @IBOutlet var customLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Set the corner radius of the customImage to make it circular
        
      
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset the image view's shape
        imageView?.layer.cornerRadius = 0
        imageView?.clipsToBounds = false
    }
}
