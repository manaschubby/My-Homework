//
//  NewTopicViewController.swift
//  My Homework
//
//  Created by Manas Ashwin on 05/11/18.
//  Copyright © 2018 Manas Producers. All rights reserved.
//

import UIKit
import CoreData

class NewTopicViewController: UIViewController {
    
    var subjectTopic : Subject?
    var context = PersistentService.persistentContainer.viewContext
    var topicsVC : TopicsViewController!
    
    @IBOutlet weak var topicTextField : UITextField!
    @IBOutlet weak var reminderPicker : UIDatePicker!
    @IBOutlet weak var saveButton : UIBarButtonItem!
    
    
    @IBAction func save(_ sender: UIBarButtonItem)
    {
       
            checkForAccountability()
        if !saveButton.isEnabled{
            
            
            let alert = UIAlertController(title: "Alet!", message: "This topic is not eligible for saving!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            
            return
        }
            //Intitialize New Topic
            let topic = Topic(context: context)
            
            //Assign the attributes
            topic.text = topicTextField.text
            topic.date = reminderPicker.date
            topic.subject = subjectTopic
            topic.completion = false
        
            //Save The Context
            PersistentService.saveContext()
            topicsVC.loadItems()
        
            dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        topicTextField.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForAccountability()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func checkForAccountability()
    {
        if topicTextField.text != "" && reminderPicker.date >= Date(){
            
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }

}

extension NewTopicViewController : UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        checkForAccountability()
            
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkForAccountability()
        
    }
    
    
    
}

