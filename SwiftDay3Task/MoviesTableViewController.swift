//
//  MoviesTableViewController.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 25/04/2024.
//

import UIKit
import Kingfisher
import SDWebImage
import Cosmos
import SQLite3


class MoviesTableViewController: UITableViewController{

    
    
    var moviesArray: [DataModel] = []

    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.reloadData()
        for i in 0 ..< moviesArray.count{
            print(moviesArray[i])
        }
        
        reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesArray.count
    }


    
    // Method to fetch data from the database and reload the table view
    func reloadData() {
        moviesArray = Database.sharedInstance().retrieveDataModels()
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)


        let movie = moviesArray[indexPath.row]

        // Apply corner radius to make the image circular
        if let imageUrl = URL(string: movie.image) {
            // Load image using Kingfisher
            cell.imageView?.kf.setImage(with: imageUrl, placeholder: UIImage(named: "loading.png") , completionHandler: {
                (image, error, cacheType, url) in
                    if let image = image {
                        cell.imageView?.contentMode = .scaleAspectFill
                        cell.imageView?.image = image
                        cell.imageView?.frame.size.width = 50
                        cell.imageView?.frame.size.height = 50
                        cell.imageView?.layer.cornerRadius = cell.imageView!.frame.width / 2
                        cell.imageView?.clipsToBounds = true


                    } else {
                        print("Can't make the image circular")
                    }

            })

        } else {
            print("Can't load image from the internet")
        }

        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.frame.size.width = 50
        cell.imageView?.frame.size.height = 50
        cell.imageView?.layer.cornerRadius = 25 // half of 50
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = movie.title;



        return cell
    }
    

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
//            fatalError("Failed to dequeue CustomTableViewCell.")
//        }
//
//        let movie = moviesArray[indexPath.row]
//
////         Apply corner radius to make the image circular
//               if let imageUrl = URL(string: movie.image) {
//                   // Load image using Kingfisher
//                   cell.customImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "loading.png") , completionHandler: {
//                       (image, error, cacheType, url) in
//                           if let image = image {
//                               cell.customImage.contentMode = .scaleAspectFill
//                               cell.customImage.image = image
//                               cell.customImage.layer.cornerRadius = cell.customImage.frame.width / 2
//                               cell.customImage.clipsToBounds = true
//
//
//                           } else {
//                               print("Can't make the image circular")
//                           }
//
//                   })
//
//               } else {
//                   print("Can't load image from the internet")
//               }
//
//        cell.customImage.layer.cornerRadius = cell.customImage.frame.width / 2
//        cell.customImage.clipsToBounds = true
//        cell.customLabel.text = movie.title
//
//        return cell
//    }

    
    @IBAction func addMovieButton(_ sender: Any) {
        performSegue(withIdentifier: "inputScreen", sender: nil)

    }

    
//    func addDataModel(dataModel:DataModel){
//        moviesArray.append(dataModel)
//      //  tableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputScreen" {
            if let inputVC = segue.destination as? InputMovieViewController {
              //  inputVC.delegate = self
            }
        }else if segue.identifier == "detailSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let selectedMovie = moviesArray[indexPath.row]
                    if let destinationVC = segue.destination as? DisplayDetailsViewController {
                        destinationVC.selectedMovie = selectedMovie
                    }
                }
            }
        
        
        print("add movie")
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }

    
    /*

     */
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
 // URL of the image you want to load
 let imageUrl = URL(string: "https://example.com/image.jpg")
 
 // Load the image using Kingfisher
 imageView.kf.setImage(with: imageUrl) { result in
     switch result {
     case .success(let value):
         // Apply corner radius to make the image circular
         self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
         self.imageView.clipsToBounds = true
     case .failure(let error):
         print("Error loading image: \(error)")
     }
 */

