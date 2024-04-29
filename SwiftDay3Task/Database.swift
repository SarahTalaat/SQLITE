//
//  Database.swift
//  SwiftDay3Task
//
//  Created by Sara Talat on 28/04/2024.
//

import Foundation
import SQLite3
import UIKit

class Database {

    // Private static instance for singleton pattern
    private static let shared = Database()
    
    // Public static method to access the shared instance
    static func sharedInstance() -> Database {
        return shared
    }
    
    private var database: OpaquePointer?
    
    // Private initializer to prevent creating instances outside the class
    private init() {}
        
    
//Open connection
func openDatabase() -> OpaquePointer? {
    //el mofta7 el 72dr at3aml m3 el database b3d kda
    var db: OpaquePointer?
    let fileUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Friends.sqlite")
    //1.path the file , reference on the opaque pointer
    if sqlite3_open(fileUrl?.path, &db) == SQLITE_OK{
        print("Successfully opened connection to database")
        return db
    }else{
        print("Unable to open database")
        return nil
    }
}

//Create database
func createTable(db:OpaquePointer?){
    
//    let createTableString =
//    """
//   CREATE TABLE FRIEND(
//   Title CHAR(256) PRIMARY KEY NOT NULL ,
//   Genre CHAR(256) ,
//   Rating Int,
//   Year INT  );
//   """
    
    let createTableString =
    """
    CREATE TABLE FRIENDS(
    Title CHAR(256) PRIMARY KEY NOT NULL,
    Genre CHAR(256),
    Rating INT,
    Year INT,
    ImageData BLOB
    );
    """
    
    //1.create a pointer to point to the next statement (as we will use it to excute this statement)
    var createTableStatement: OpaquePointer?
    
    //2.Convert the statement to byte code to  execute the statement
    //sqlite3_prepare_v2 : built in function to convert statement byte code and return statement code
    //db:
    //createTableString : This is the statement that we want to compile
    //-1 : maximum lengnth that the sqlite ill read from the statement , -1 let it read full statement
    //&createTableStatement : the pointer that will point to the compiled statement so that step 3 can use it
    //nil : tail (we don't need to use it )
    if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
        //3.if the sqlite can execute the compiled statement it will continue
        if sqlite3_step(createTableStatement)==SQLITE_DONE{
            print("\nFriend table createdd")
        }else{
            print("\nFriend table is not created")
        }
    }else{
        // Check if the error is due to the table already existing
        if sqlite3_errcode(db) == SQLITE_CONSTRAINT {
            print("Table already exists")
        
        // Print an error message if the statement couldn't be compiled
              print("Error preparing create table statement: \(String(cString: sqlite3_errmsg(db)))")
        } else {
            print("Create table statement is not prepared")

        }
    //4.Built in method to avoid memory leak
    sqlite3_finalize(createTableStatement)
 
    }
}

 /*
 
// Function to insert a DataModel object into the FRIEND table
func insertDataModelInDb(dataModel: DataModel) {
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return
        }
        
        // Prepare the INSERT statement
        let insertStatementString = "INSERT INTO FRIEND (Title, Genre, Rating, Year) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            // Bind the values to the placeholders in the prepared statement
            let title = dataModel.title as NSString
            let genre = dataModel.genere.joined(separator: ", ") as NSString  // Join array of strings into a single string
            
            sqlite3_bind_text(insertStatement, 1, title.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, genre.utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 3, Double(dataModel.rating))
            sqlite3_bind_int(insertStatement, 4, Int32(dataModel.year))
            
            
            // Execute the statement to insert the values into the table
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("DataModel inserted successfully.")
                print("DataModel inserted successfully.")
                
                // Print the inserted values
                print("Inserted Values:")
                print("Title: \(dataModel.title)")
                print("Genre: \(dataModel.genere)")
                print("Rating: \(dataModel.rating)")
                print("Year: \(dataModel.year)")
            } else {
                print("Failed to insert DataModel.")
            }
        } else {
            print("Error preparing insert statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(insertStatement)
        
        // Close the database connection
        sqlite3_close(db)
    }

    
    // Function to retrieve DataModel objects from the FRIEND table
    func retrieveDataModels() -> [DataModel] {
        var dataModels: [DataModel] = []
        
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return dataModels
        }
        
        // Prepare the SELECT statement
        let query = "SELECT * FROM FRIEND;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            // Execute the SELECT statement
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                // Retrieve values from the query result
                let title = String(cString: sqlite3_column_text(queryStatement, 0))
                let genre = String(cString: sqlite3_column_text(queryStatement, 1))
                let rating = sqlite3_column_double(queryStatement, 2)
                let year = Int(sqlite3_column_int(queryStatement, 3))
                
                // Split the genre string into an array
                let genresArray = genre.components(separatedBy: ", ")
                
                // Create DataModel object and append to the array
                let dataModel = DataModel(title: title, image: " ", rating: Float(rating), year: Int(rating), genere: genresArray)
                dataModels.append(dataModel)
            }
        } else {
            print("Error preparing query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(queryStatement)
        
        // Close the database connection
        sqlite3_close(db)
        
        return dataModels
    }
    
    */
    
    // Function to insert a DataModel object into the FRIEND table
    func insertDataModelInDb(dataModel: DataModel) {
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return
        }
        
        let insertStatementString = "INSERT INTO FRIENDS (Title, Genre, Rating, Year, ImageData) VALUES (?, ?, ?, ?, ?);"

        var insertStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            // Bind the values to the placeholders in the prepared statement
            let title = dataModel.title as NSString
            let genre = dataModel.genere.joined(separator: ", ") as NSString  // Join array of strings into a single string
            
            sqlite3_bind_text(insertStatement, 1, title.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, genre.utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 3, Double(dataModel.rating))
            sqlite3_bind_int(insertStatement, 4, Int32(dataModel.year))
            
            // Convert UIImage to NSData
            if let imageData = dataModel.image?.jpegData(compressionQuality: 1.0) as NSData? {
                sqlite3_bind_blob(insertStatement, 5, imageData.bytes, Int32(imageData.length), nil)
            } else {
                print("Error converting image to data.")
                return
            }
            
            
            
            // Execute the statement to insert the values into the table
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("DataModel inserted successfully.")
                
                // Print the inserted values
                print("Inserted Values:")
                print("Title: \(dataModel.title)")
                print("Genre: \(dataModel.genere)")
                print("Rating: \(dataModel.rating)")
                print("Year: \(dataModel.year)")
            } else {
                print("Failed to insert DataModel.")
            }
        } else {
            print("Error preparing insert statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(insertStatement)
        
        // Close the database connection
        sqlite3_close(db)
    }
    // Function to retrieve DataModel objects from the FRIEND table
    func retrieveDataModels() -> [DataModel] {
        var dataModels: [DataModel] = []
        
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return dataModels
        }
        
        // Prepare the SELECT statement
        let query = "SELECT * FROM FRIENDS;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            // Execute the SELECT statement
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                // Retrieve values from the query result
                let title = String(cString: sqlite3_column_text(queryStatement, 0))
                let genre = String(cString: sqlite3_column_text(queryStatement, 1))
                let rating = sqlite3_column_double(queryStatement, 2)
                let year = Int(sqlite3_column_int(queryStatement, 3))
                
                // Retrieve image data as NSData
                let imageDataPointer = sqlite3_column_blob(queryStatement, 4)
                let imageDataSize = sqlite3_column_bytes(queryStatement, 4)
                let imageData = NSData(bytes: imageDataPointer, length: Int(imageDataSize))
                
                // Unwrap the optional UIImage? safely
                var image: UIImage
                if let imageData = imageData as Data?, let img = UIImage(data: imageData) {
                    image = img
                } else {
                    // Use a default image if the optional is nil
                    image = UIImage(named: "default_image") ?? UIImage() // Provide a default image here
                }
                
                // Split the genre string into an array
                let genresArray = genre.components(separatedBy: ", ")
                
                // Create DataModel object and append to the array
                let dataModel = DataModel(title: title, image: image, rating: Float(rating), year: year, genere: genresArray)
                dataModels.append(dataModel)
            }
        } else {
            print("Error preparing query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(queryStatement)
        
        // Close the database connection
        sqlite3_close(db)
        
        return dataModels
    }


  
  
//
//    // Function to insert a DataModel object into the FRIEND table
//    func insertDataModelInDb(dataModel: DataModel) {
//        guard let db = openDatabase() else {
//            print("Unable to open database")
//            return
//        }
//
//        let insertStatementString = "INSERT INTO FRIEND (Title, Genre, Rating, Year, ImageData) VALUES (?, ?, ?, ?, ?);"
//        var insertStatement: OpaquePointer?
//
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            let title = dataModel.title as NSString
//            let genre = dataModel.genere.joined(separator: ", ") as NSString
//
//            sqlite3_bind_text(insertStatement, 1, title.utf8String, -1, nil)
//            sqlite3_bind_text(insertStatement, 2, genre.utf8String, -1, nil)
//            sqlite3_bind_double(insertStatement, 3, Double(dataModel.rating))
//            sqlite3_bind_int(insertStatement, 4, Int32(dataModel.year))
//
//            if let imageData = dataModel.image?.jpegData(compressionQuality: 1.0) as NSData? {
//                sqlite3_bind_blob(insertStatement, 5, imageData.bytes, Int32(imageData.length), nil)
//            } else {
//                print("Error converting image to data.")
//                return
//            }
//
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("DataModel inserted successfully.")
//            } else {
//                print("Failed to insert DataModel.")
//            }
//        } else {
//            print("Error preparing insert statement: \(String(cString: sqlite3_errmsg(db)))")
//        }
//
//        sqlite3_finalize(insertStatement)
//        sqlite3_close(db)
//    }
//
//    // Function to retrieve DataModel objects from the FRIEND table
//    func retrieveDataModels() -> [DataModel] {
//        var dataModels: [DataModel] = []
//
//        guard let db = openDatabase() else {
//            print("Unable to open database")
//            return dataModels
//        }
//
//        let query = "SELECT * FROM FRIEND;"
//        var queryStatement: OpaquePointer?
//
//        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let title = String(cString: sqlite3_column_text(queryStatement, 0))
//                let genre = String(cString: sqlite3_column_text(queryStatement, 1))
//                let rating = sqlite3_column_double(queryStatement, 2)
//                let year = Int(sqlite3_column_int(queryStatement, 3))
//
//                let imageDataPointer = sqlite3_column_blob(queryStatement, 4)
//                let imageDataSize = sqlite3_column_bytes(queryStatement, 4)
//                let imageData = NSData(bytes: imageDataPointer, length: Int(imageDataSize))
//                let image = UIImage(data: imageData as Data) ?? UIImage() // default value for image
//
//                let genresArray = genre.components(separatedBy: ", ")
//
//                let dataModel = DataModel(title: title, image: image, rating: Float(rating), year: year, genere: genresArray)
//                dataModels.append(dataModel)
//            }
//        } else {
//            print("Error preparing query statement: \(String(cString: sqlite3_errmsg(db)))")
//        }
//
//        sqlite3_finalize(queryStatement)
//        sqlite3_close(db)
//
//        return dataModels
//    }


    func deleteDataModelFromDb(title: String) {
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return
        }
        
        // Prepare the DELETE statement
        let deleteStatementString = "DELETE FROM FRIENDS WHERE Title = ?;"
        var deleteStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            // Bind the value to the placeholder in the prepared statement
            let titleNSString = title as NSString
            sqlite3_bind_text(deleteStatement, 1, titleNSString.utf8String, -1, nil)
            
            // Execute the statement to delete the record from the table
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("DataModel deleted successfully.")
            } else {
                print("Failed to delete DataModel.")
            }
        } else {
            print("Error preparing delete statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(deleteStatement)
        
        // Close the database connection
        sqlite3_close(db)
    }

    
    
    
    
    // Function to check if a title already exists in the FRIEND table
    func checkTitleExists_PK(title: String) -> Bool {
        // Open connection to the database
        guard let db = openDatabase() else {
            print("Unable to open database")
            return false
        }
        
        // Prepare the SELECT statement to check if the title exists
        let query = "SELECT * FROM FRIENDS WHERE Title = ?;"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            // Bind the title value to the prepared statement
            sqlite3_bind_text(queryStatement, 1, title, -1, nil)
            
            // Execute the SELECT statement
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // If a row is returned, the title exists in the database
                sqlite3_finalize(queryStatement)
                sqlite3_close(db)
                return true
            }
        } else {
            print("Error preparing query statement: \(String(cString: sqlite3_errmsg(db)))")
        }
        
        // Finalize the prepared statement to avoid memory leaks
        sqlite3_finalize(queryStatement)
        
        // Close the database connection
        sqlite3_close(db)
        
        // If no rows were returned, the title doesn't exist in the database
        return false
    }

    
}
