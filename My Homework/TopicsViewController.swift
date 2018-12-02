//
//  TopicsViewController.swift
//  My Homework
//
//  Created by Manas Ashwin on 27/07/18.
//  Copyright © 2018 Manas Producers. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class TopicsViewController: UITableViewController {
    
    var homework = [Topic]()
    var selectedSubject : Subject? {
        didSet {
            loadItems()
        }
        
    }
    var context = PersistentService.persistentContainer.viewContext
    
    // MARK : ACTIONS
    @IBAction func addButtonPressed(sender: Any)
    {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homework.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homework")

        // Configure the cell...
        
        cell!.textLabel?.text = homework[indexPath.row].text
        cell!.detailTextLabel?.text = homework[indexPath.row].date?.description
        cell?.accessoryType = homework[indexPath.row].completion ? .checkmark : .none
        
        
        return cell!
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as? NewTopicViewController
        
        destination?.subjectTopic = self.selectedSubject
        destination?.topicsVC = self
        
    }
    

    
    // MARK: - Private Methods
    
    // TODO: LoadItems
    func loadItems(){
        
        let request : NSFetchRequest<Topic> = Topic.fetchRequest()
        let predicate = NSPredicate(format: "subject.name MATCHES %@", selectedSubject!.name!)

        request.predicate = predicate
//
        do {
            homework = try context.fetch(request)
            tableView.reloadData()
        }catch{
            fatalError()
        }
    }
    @IBAction func unwindToTopicsView(_ unwindSegue: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
        loadItems()
    }
}

extension TopicsViewController
{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        homework[indexPath.row].completion = !homework[indexPath.row].completion
        tableView.reloadData()
    }
    
}
