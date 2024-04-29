//
//  InputMovieViewController.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 25/04/2024.
//

import UIKit
import SQLite3

class InputMovieViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    var selectedImage: UIImage?
    var imageSelected: Bool = false
    
    @IBOutlet var imageUrl: UITextField!
    @IBOutlet var ratingValue: UITextField!
    @IBOutlet var genreValue: UITextField!
    @IBOutlet var yearValue: UITextField!
    @IBOutlet var titleValue: UITextField!
    
   // var delegate: CommunicationDelegate?





    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let db = Database.sharedInstance().openDatabase()
        Database.sharedInstance().createTable(db: db)
        
        
    }
    
    @IBAction func imagePickerButton(_ sender: Any) {
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }else{
            print("Can't open the photoLibrary")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("Unable to select image")
            self.dismiss(animated: true)
            return
        }
        
        // Convert the image to NSData
        guard let imageData = image.pngData() else {
            print("Unble to convert image to NSData")
            self.dismiss(animated: true)
            return
        }
        
        selectedImage = image
        imageSelected = true
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        
        var title_input = titleValue.text
        var year_input = Int(yearValue.text ?? "") // Parse as Int
        var genre_input = genreValue.text
        var rating_input = Float(ratingValue.text ?? "") // Parse as Float
        var image_input = selectedImage
        
        // Check if year is a valid integer
        guard let year = year_input else {
            showAlert(title: "Invalid Year", message: "Please enter a valid year.")
            return
        }
        
        // Check if the title already exists in the database
        if Database.sharedInstance().checkTitleExists_PK(title: title_input ?? ""){
            showAlert(title: "Title Exists", message: "The title already exists in the database.")
            return
        }
        
        // Check if rating is a valid float and within the range 0 to 5
        guard let rating = rating_input, rating >= 0 && rating <= 5 else {
            showAlert(title: "Invalid Rating", message: "Please enter a valid rating between 0 and 5.")
            return
        }
        
        
        guard let selectedImage = selectedImage else {
            showAlert(title: "Invalid Input", message: "Please select an image.")
            return
        }

        
        var genreArray: [String] = []
        if let genre = genre_input {
            genreArray.append(genre)
        }
        genreArray.joined(separator: " , ")
        
        var dataModel: DataModel = DataModel(title: title_input ?? "", image: selectedImage ,rating: rating, year: year, genere: genreArray)
       // delegate?.addDataModel(dataModel: dataModel)
        Database.sharedInstance().insertDataModelInDb(dataModel: dataModel)
    
    //    insertDataModelInDb(dataModel: dataModel)
        
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

        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




}
