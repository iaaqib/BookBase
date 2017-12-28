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
        coreDataManager.saveBookToCoreData(bookTitle: "Game of Thrones", authorName: "R.R Martin")
        
    }
    
    @IBAction func searchFromCoreData(_ sender: UIButton){
        
    }
}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksList", for: indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}


