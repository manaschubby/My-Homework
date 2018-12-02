//
//  ViewController.swift
//  My Homework
//
//  Created by Manas Ashwin on 24/07/18.
//  Copyright © 2018 Manas Producers. All rights reserved.
//

import UIKit
import SwipeCellKit
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
        print(subjects)
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
        cell?.delegate = self
        cell?.subjectLabel.text = subjects[indexPath.row].name!
        
        return cell!
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    @IBAction func newSubject(sender : Any?)
    {
        
        addNewSubject()
        
        
    }
    
    func addNewSubject(){
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
                alertController.dismiss(animated: true, completion: nil)
                self.subjects.append(subject)
                PersistentService.saveContext()
                self.tableView.reloadData()
            }
            
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let destination = navVC.topViewController as! TopicsViewController
 
        destination.selectedSubject = subjects[(tableView.indexPathForSelectedRow?.row)!]
        
        
    }
    @IBAction func unwindToMyHomework(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        
    }
}


extension MyHomework: SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let action = SwipeAction(style: .destructive, title: "Delete") { (action, indexpath) in
            
            //Getting Topics under deleted subject
            let request : NSFetchRequest<Topic> = Topic.fetchRequest()
            let predicate = NSPredicate(format: "subject.name MATCHES %@", self.subjects[indexPath.row].name!)
            
            request.predicate = predicate
            
            
            let items = try! self.context.fetch(request)
            for topic in items{
                self.context.delete(topic)
            }
            
            
            self.context.delete(self.subjects[indexPath.row])
            
            self.subjects.remove(at: indexPath.row)
            PersistentService.saveContext()
            tableView.reloadData()
        }
        return [action]
    }
    
    
}

