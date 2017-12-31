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
            authors = try context.fetch(Authors.fetchRequest())
            
        }
        catch {
            debugPrint("Fetching Failed")
        }
    }
    
    //MARK: Save Books in CoreData
    func saveBookToCoreData(bookTitle: String, authorName: String, completion:(_ isSaved: Bool) ->()){
        guard (self.books.filter{ $0.bookTitle == bookTitle}).first != nil else {
            let books = Books(context: context)
            books.bookTitle = bookTitle
            
            
            let authorNameArray = authorName.split(separator: ",")
            var authorArray: [Authors] = []
            for authorName in authorNameArray{
                
                let filteredAuthors = authors.filter{$0.authorName!.lowercased() == String(authorName).lowercased()}.first
                if filteredAuthors == nil{
                    let author = Authors(context: context)
                    author.authorName = String(authorName)
                    author.addToHasBooks(books)
                    authorArray.append(author)
                    self.authors.append(author)
                }else{
                    filteredAuthors!.addToHasBooks(books)
                    authorArray.append(filteredAuthors!)
                }
            }
            let authorSet = NSSet(array: authorArray)
            books.addToHasAuthors(authorSet)
            self.books.append(books)
            
            self.saveContext()
            completion(true)
            return
        }
        completion(false)
        
    }
    
    //MARK: Search Results
    private func searchBookByBookTitle(bookTitle: String) -> (books: [Books]?, authorsName: [String]?){
        
        let filteredBooks = books.filter { (book: Books) -> Bool in
            return book.bookTitle!.lowercased().contains(bookTitle.lowercased())
        }
        let authorsName = filteredBooks.flatMap{($0.hasAuthors?.allObjects as? [Authors]).flatMap{$0.flatMap{$0.authorName}}}.map{$0.joined(separator: ", ")}
        
        return (filteredBooks, authorsName)
    }
    
    private func searchBookByAuthorName(authorName: String) -> (books: [Books]?, authorsName: [String]?){
        
        let books = authors.filter({ (author: Authors) -> Bool in
            return author.authorName!.lowercased().contains(authorName.lowercased())
        }).flatMap{$0.hasBooks?.allObjects as? [Books]}.flatMap{$0}
        let authorsName = books.flatMap{($0.hasAuthors?.allObjects as? [Authors]).flatMap{$0.flatMap{$0.authorName}}}.map{$0.joined(separator: ", ")}
        return (books, authorsName)
    }
    
    func searchBook(bookTitle: String?, authorName: String?) -> (books: [Books]?, authorsName: [String]?){
        
        if let bookName = bookTitle, bookName != ""{
            
            return searchBookByBookTitle(bookTitle: bookName)
            
        }else if let author = authorName, author != ""{
            
            return searchBookByAuthorName(authorName: author)
        }
        return (nil, nil)
    }
    
    //CoreData Save Context
    private func saveContext(){
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
}
