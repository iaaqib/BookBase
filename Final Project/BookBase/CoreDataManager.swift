//
//  CoreDataManager.swift
//  BookBase
//
//  Created by Aaqib Hussain on 25/12/17.
//  Copyright © 2017 Aaqib Hussain. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    //Container Context
    fileprivate lazy var context: NSManagedObjectContext = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return context
    }()
    
    //Contains Fetched Tasks
    lazy var books: [Books] = []
    //MARK: Init
    override init() {
        getBook()
        
    }
    
    //MARK: CoreData Operations
    
    //Fetch from CoreData
    private func getBooks(){
        do {
            books = try context.fetch(Books.fetchRequest())
            
        }
        catch {
            debugPrint("Fetching Failed")
        }
    }
    
    //Sets Task in CoreData
    func saveBookToCoreData(bookTitle: String, authorName: String){
        guard (self.books.filter{ $0.bookTitle == bookTitle}).first != nil else {
            let books = Books(context: context)
            books.bookTitle = bookTitle
            
            let authorArray = authorName.split(separator: ",")
            
            let authorSet = NSSet(array: authorArray)
            books.addToHasAuthors(authorSet)
            
            
            self.saveContext()
            
            return
        }
        
      
        
       
       
        
        
    }
    
    
    private func saveContext(){
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }

}
