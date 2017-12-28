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
     var books: [Books] = []
     var authors: [Authors] = []
    
    
    //MARK: init
    override init() {
      super.init()
        
        getAllEntities()
        
    }
    
    
    //Fetch from CoreData
    private func getAllEntities(){
        do {
            books = try context.fetch(Books.fetchRequest())
            print((books.first?.hasAuthors?.allObjects as? [Authors])?.first?.authorName)
            authors = try context.fetch(Authors.fetchRequest())
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
            
            let authorNameArray = authorName.split(separator: ",")
            var authorArray: [Authors] = []
            for authorName in authorNameArray{
                let author = Authors(context: context)
                    author.authorName = String(authorName)
                if !authors.contains(author){
                    authorArray.append(author)
                    self.authors.append(author)
                }
            }
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
