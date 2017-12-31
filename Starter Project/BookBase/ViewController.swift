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
    }
    
    @IBAction func searchFromCoreData(_ sender: UIButton){
        
    }
    
    @IBAction func refreshList(_ sender: UIBarButtonItem) {
        
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
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}


