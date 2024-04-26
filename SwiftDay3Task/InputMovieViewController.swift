//
//  InputMovieViewController.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 25/04/2024.
//

import UIKit

class InputMovieViewController: UIViewController  {

    

    @IBOutlet var imageUrl: UITextField!
    @IBOutlet var ratingValue: UITextField!
    @IBOutlet var genreValue: UITextField!
    @IBOutlet var yearValue: UITextField!
    @IBOutlet var titleValue: UITextField!
    
    var delegate: CommunicationDelegate?


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        
    }

    @IBAction func doneButton(_ sender: Any) {
        
        var title_input = titleValue.text
        var year_input = Int(yearValue.text ?? "0" ) ?? 0
        var genre_input = genreValue.text
        var rating_input = Float(ratingValue.text ?? "0.0") ?? 0.0
        var image_input = imageUrl.text
        
        var genreArray:[String] = []
        if let genre = genre_input {
            genreArray.append(genre)
        }
        genreArray.joined(separator: " , ")
    
        
        if rating_input > 5 {
            // Rating exceeds 5, display an alert
            let alertController = UIAlertController(title: "Rating Limit Exceeded", message: "The maximum rating is 5.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {

            var dataModel : DataModel = DataModel(title:title_input ?? "", image: image_input ?? "", rating: rating_input ?? 0.0 , year: year_input , genere: genreArray )
            delegate?.addDataModel(dataModel: dataModel)
            navigationController?.popViewController(animated: true)
            
            print(title_input)
            print(year_input)
            print(genre_input)
            print(rating_input)
            print(image_input)
            
        }
        


        
        
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
