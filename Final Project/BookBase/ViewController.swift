//
//  ViewController.swift
//  BookBase
//
//  Created by Aaqib Hussain on 24/12/17.
//  Copyright © 2017 Aaqib Hussain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var coreDataManager = CoreDataManager()
    lazy var searchedBooks: (books: [Books], authorsName: [String]) = ([], [])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    
    @IBAction func addToCoreData(_ sender: UIButton) {
        guard let bookTitle = bookNameTextField.text, let authorName = authorNameTextField.text, bookTitle != "", authorName != "" else{
           
           showAlert(title: "Cannot Proceed", message: "Both fields are required.")
            return
        }
        coreDataManager.saveBookToCoreData(bookTitle: bookTitle, authorName: authorName) { (isSaved) in
            if !isSaved{
            self.showAlert(title: "Cannot Proceed", message: "This Book is already in the library.")
            }
        }
        clearTextFields()
    }
    
    @IBAction func searchFromCoreData(_ sender: UIButton){
        
       guard let (searchBooks, authors) =         coreDataManager.searchBook(bookTitle: bookNameTextField.text, authorName: authorNameTextField.text)  as? ([Books], [String]) else{return}

        searchedBooks = (searchBooks, authors)
        tableView.reloadData()
        
    }
    
    @IBAction func refreshList(_ sender: UIBarButtonItem) {
        searchedBooks = ([],[])
        tableView.reloadData()
        clearTextFields()
    }
    
    //AlertController method
    func showAlert(title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    //Clear Fields
    func clearTextFields(){
        authorNameTextField.text = ""
        bookNameTextField.text = ""
    }
}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksList", for: indexPath)
        cell.textLabel?.text = searchedBooks.books[indexPath.row].bookTitle
        cell.detailTextLabel?.text = searchedBooks.authorsName[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBooks.books.count
    }
}


