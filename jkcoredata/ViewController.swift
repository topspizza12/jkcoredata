//
//  ViewController.swift
//  jkcoredata
//
//  Created by mac on 20/08/18.
//  Copyright © 2018 jeky. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var add: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var id: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
       
    }
    func ClearField()
    {
        id.text = ""
        name.text = ""
        add.text = ""
        
        id.becomeFirstResponder()
    }

    @IBAction func Insert(_ sender: UIButton)
    {
        let newrecord = NSEntityDescription.insertNewObject(forEntityName: "Jaykishan", into: context)
        newrecord.setValue(id.text!, forKey: "id")
        newrecord.setValue(name.text!, forKey: "name")
        newrecord.setValue(add.text!, forKey: "add")
        do{
            try context.save()
            ClearField()
        }catch{}
    }
    
    @IBAction func Select(_ sender: UIButton)
    {
        let entitydesc = NSEntityDescription.entity(forEntityName: "Jaykishan", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Jaykishan")
        request.entity = entitydesc
        
        let pred = NSPredicate(format: "(id=%@)", id.text!)
        request.predicate = pred
        do
        {
            let result = try context.fetch(request)
            if result.count>0
            {
                let manage = result[0] as! NSManagedObject
                
                id.text = manage.value(forKey: "id") as? String
                add.text = manage.value(forKey: "add") as? String
                name.text = manage.value(forKey: "name") as? String
            }
            
        }catch{}
    }
    
    @IBAction func Update(_ sender: UIButton)
    {
        let entitydesc = NSEntityDescription.entity(forEntityName: "Jaykishan", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Jaykishan")
        request.entity = entitydesc
        
        let pred = NSPredicate(format: "(id=%@)", id.text!)
        request.predicate = pred
        
        do{
            let result = try context.fetch(request)
            
            if result.count>0
            {
                let manage = result[0] as! NSManagedObject
                
                manage.setValue(id.text!, forKey: "id")
                manage.setValue(name.text!, forKey: "name")
                manage.setValue(add.text!, forKey: "add")
                do
                {
                    try context.save()
                    ClearField()
                    
                }catch{}
                
                
            }
        }catch{}
    }
    
    @IBAction func Delete(_ sender: UIButton)
    {
        let entitydesc = NSEntityDescription.entity(forEntityName: "Jaykishan", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Jaykishan")
        request.entity = entitydesc
        
        let pred = NSPredicate(format: "(id=%@)", id.text!)
        request.predicate = pred
        
        do{
            let result = try context.fetch(request)
            
            if result.count>0
            {
                let manage = result[0] as! NSManagedObject
                context.delete(manage)
               
                do
                {
                    try context.save()
                    ClearField()
                    
                }catch{}
                
                
            }
        }catch{}
    }
    
    func GetData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Jaykishan")
        
        do
        {
            let arr = try context.fetch(request) as! [NSManagedObject]
            print(arr)
            
        }catch{}
    }
        
}

