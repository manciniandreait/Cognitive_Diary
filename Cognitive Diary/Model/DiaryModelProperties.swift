//
//  DiaryModel+CoreDataProperties.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//
//

import Foundation
import CoreData
import UIKit


extension DiaryModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<DiaryModel>
    {
            return NSFetchRequest<DiaryModel>(entityName: "DiaryEntity")
        }
        
    @nonobjc public class func createEntity(in_context: NSManagedObjectContext) -> NSEntityDescription?
    {
        return NSEntityDescription.entity(forEntityName: "DiaryEntity", in: in_context)
    }
    
    @nonobjc public class func fetchData() throws -> [DiaryModel]?
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = DiaryModel.createFetchRequest()
        
        return try managedContext.fetch(fetchRequest)
    }


    @NSManaged public var a: String?
    @NSManaged public var b: String?
    @NSManaged public var c: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension DiaryModel : Identifiable {

}
