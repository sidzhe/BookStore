//
//  CoreDataManager.swift
//  BookStore
//
//  Created by macbook on 14.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TestCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //MARK: - Save bookModel
    func saveBook(from bookModel: Book) {
        let bookCD = BookCD(context: viewContext)
        bookCD.authorName = bookModel.authorName?.first
        bookCD.iaCollection = bookModel.iaCollection?.first
        bookCD.title = bookModel.title
        bookCD.urlImage = bookModel.urlImage.absoluteString
        
        saveContext()
    }
    //MARK: - Get Book from Core Data
    func getBook() -> [BookCD] {
        let bookFetchRequest = BookCD.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        bookFetchRequest.sortDescriptors = [sortDescriptor]
        guard let result = try? viewContext.fetch(bookFetchRequest) else { return [] }
        return result
    }
    
    //MARK: - Delete Book from Core Data
    func deleteBook(_ book: BookCD) throws {
        viewContext.delete(book)
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
}
