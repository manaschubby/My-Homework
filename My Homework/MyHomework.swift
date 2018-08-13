//
//  ViewController.swift
//  My Homework
//
//  Created by Manas Ashwin on 24/07/18.
//  Copyright © 2018 Manas Producers. All rights reserved.
//

import UIKit
import CoreData

class MyHomework: UITableViewController {
    var subjects = [Subject]()
    let context = PersistentService.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fetchRequest : NSFetchRequest<Subject> = Subject.fetchRequest()
        do{
            subjects += try context.fetch(fetchRequest)
        }catch{
            fatalError()
        }
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SubjectCell
        cell?.subjectLabel.text = subjects[indexPath.row].name!
        
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    @IBAction func newSubject(sender : Any?)
    {
        let alertController = UIAlertController(title: "New Subject", message: "Add A New Subject To Your Vast Homework List.", preferredStyle: .alert)
        var maintextField = UITextField()
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Subject Name"
            maintextField = textField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let subject = Subject(context: self.context)
            if let text = maintextField.text{
                subject.name = text
                alertController.dismiss(animated: true, completion: {
                    self.tableView.reloadData()
                })

            }
            
        }
        alertController.addAction(action)
        
    }}

