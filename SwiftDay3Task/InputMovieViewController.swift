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
//
//    @IBAction func doneButton(_ sender: Any) {
//
//        var title_input = titleValue.text
//        var year_input = Int(yearValue.text ?? "0" ) ?? 0
//        var genre_input = genreValue.text
//        var rating_input = Float(ratingValue.text ?? "0.0") ?? 0.0
//        var image_input = imageUrl.text
//
//        var genreArray:[String] = []
//        if let genre = genre_input {
//            genreArray.append(genre)
//        }
//        genreArray.joined(separator: " , ")
//
//
//        if rating_input > 5 {
//            // Rating exceeds 5, display an alert
//            let alertController = UIAlertController(title: "Rating Limit Exceeded", message: "The maximum rating is 5.", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alertController, animated: true, completion: nil)
//        } else {
//
//            var dataModel : DataModel = DataModel(title:title_input ?? "", image: image_input ?? "", rating: rating_input ?? 0.0 , year: year_input , genere: genreArray )
//            delegate?.addDataModel(dataModel: dataModel)
//
//            navigationController?.popViewController(animated: true)
//
//            print(title_input)
//            print(year_input)
//            print(genre_input)
//            print(rating_input)
//            print(image_input)
//
//        }
//
    @IBAction func doneButton(_ sender: Any) {
        
        var title_input = titleValue.text
        var year_input = Int(yearValue.text ?? "") // Parse as Int
        var genre_input = genreValue.text
        var rating_input = Float(ratingValue.text ?? "") // Parse as Float
        var image_input = imageUrl.text
        
        // Check if year is a valid integer
        guard let year = year_input else {
            showAlert(title: "Invalid Year", message: "Please enter a valid year.")
            return
        }
        
        // Check if rating is a valid float and within the range 0 to 5
        guard let rating = rating_input, rating >= 0 && rating <= 5 else {
            showAlert(title: "Invalid Rating", message: "Please enter a valid rating between 0 and 5.")
            return
        }
        
        // Check if URL is valid
        guard let imageUrlString = image_input, let _ = URL(string: imageUrlString) else {
            showAlert(title: "Invalid URL", message: "Please enter a valid URL.")
            return
        }
        
        var genreArray: [String] = []
        if let genre = genre_input {
            genreArray.append(genre)
        }
        genreArray.joined(separator: " , ")
        
        var dataModel: DataModel = DataModel(title: title_input ?? "", image: image_input ?? "", rating: rating, year: year, genere: genreArray)
        delegate?.addDataModel(dataModel: dataModel)
        
        navigationController?.popViewController(animated: true)
        
        print(title_input)
        print(year)
        print(genre_input)
        print(rating)
        print(image_input)
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
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



