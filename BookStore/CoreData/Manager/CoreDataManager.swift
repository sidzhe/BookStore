//
//  CoreDataManager.swift
//  BookStore
//
//  Created by macbook on 14.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: - Init
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "BookCoreData")
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
    func saveBook(from bookModel: Work) {
        let fetchRequest: NSFetchRequest<BookCD> = BookCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", bookModel.title ?? "")
        
        do {
            let existingBooks = try viewContext.fetch(fetchRequest)
            if let existingBook = existingBooks.first {
                try deleteBook(existingBook)
            }
        } catch {
            print(error.localizedDescription)
            return
        }
        
        let bookCD = BookCD(context: viewContext)
        bookCD.authorName = bookModel.authorName?.first
        bookCD.iaCollection = bookModel.key
        bookCD.title = bookModel.title
        bookCD.urlImage = String(bookModel.cover_i ?? 0)
        saveContext()
    }
    
    //MARK: - Save liked Book
    func saveLikedBook(from model: Work) -> Bool {
        let likedBook = LikedBooks(context: viewContext)
        likedBook.author = model.authorName?.first
        likedBook.title = model.title
        likedBook.coverI = Int64(model.cover_i ?? 0)
        likedBook.key = model.key
        likedBook.isSelected = true
        
        do {
            try viewContext.save()
            return true
        } catch {
            return false
        }
    }
    
    //MARK: - Get Book from Core Data
    func getBook() -> [Work]? {
        let bookFetchRequest = BookCD.fetchRequest()
        guard let result = try? viewContext.fetch(bookFetchRequest) else { return [] }
        let work = result.map { Work(key: $0.iaCollection, title: $0.title, coverEditionKey: nil, cover_i: $0.imageUrl, authorName: [$0.authorName ?? ""]) }
        return work.reversed()
    }
    
    //MARK: - Get liked book
    func getLikedBook() -> [Work]? {
        let likedBookRequest = LikedBooks.fetchRequest()
        do {
            let result = try viewContext.fetch(likedBookRequest)
            let work = result.map { Work(key: $0.key, title: $0.title, coverEditionKey: nil, cover_i: Int($0.coverI), authorName: [$0.author ?? ""])
            }
            return work
        } catch {
            return []
        }
    }
    
    //MARK: - Is book liked
    func isBookLiked(bookKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<LikedBooks> = LikedBooks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", bookKey)
        
        do {
            let existingBooks = try viewContext.fetch(fetchRequest)
            if let existingBook = existingBooks.first {
                return existingBook.isSelected
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    //MARK: - Delete Book from Core Data
    func deleteBook(_ book: BookCD) throws {
        viewContext.delete(book)
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
    
    //MARK: - Delete liked book
    func deleteLiked(_ book: LikedBooks) throws {
        viewContext.delete(book)
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
    
    func deleteLikeBook(from bookModel: Work) {
        let fetchRequest: NSFetchRequest<LikedBooks> = LikedBooks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", bookModel.key ?? "")
        
        do {
            let existingBooks = try viewContext.fetch(fetchRequest)
            if let existingBook = existingBooks.first {
                try deleteLiked(existingBook)
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    // MARK: - List Methods
    func loadList() -> [String]? {
        let listRequest = List.fetchRequest()
        do {
            let items = try viewContext.fetch(listRequest)
            let output = items.compactMap { $0.listName }
            return output.reversed()
        } catch {
            print("Load list error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveList(listName: String) {
        let list = List(context: viewContext)
        list.listName = listName
        saveContext()
    }
    
    func saveListBook(from model: Book, parentName: String) {
        let listBook = ItemList(context: viewContext)
        let list = List(context: viewContext)
        list.listName = parentName
        listBook.parentItem = list
        listBook.authorName = model.authorName?.first
        listBook.title = model.title
        listBook.coverI = Int64(model.coverI ?? 0)
        listBook.key = model.key
        listBook.isSelected = true
        
        do {
            try viewContext.save()
        } catch {
            print("Save list book error: \(error.localizedDescription)")
        }
    }
    
    func loadListItems(parentCategory: String) -> [Book]? {
        let itemListRequest: NSFetchRequest<ItemList> = ItemList.fetchRequest()
        let categoryName = List(context: viewContext)
        categoryName.listName = parentCategory
        print("categoryName.listName \(categoryName.listName)")
        let predicateLoad = NSPredicate(format: "parentItem.listName MATCHES %@", categoryName.listName ?? "")
        
        if let predicateSort = itemListRequest.predicate {
            itemListRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateLoad, predicateSort])
        } else {
            itemListRequest.predicate = predicateLoad
        }
        
        do {
            let items = try viewContext.fetch(itemListRequest)
            
            let output = items.map {
                Book(
                    key: $0.key,
                    type: nil,
                    seed: nil,
                    title: $0.title,
                    ia: nil,
                    iaCollection: nil,
                    coverI: Int($0.coverI),
                    authorName: [$0.authorName ?? ""]
                )
            }
            return output
        } catch {
            print("Load list items error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func isBookList(bookKey: String) -> Bool {
        let fetchRequest: NSFetchRequest<ItemList> = ItemList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key == %@", bookKey)
        
        do {
            let existingBooks = try viewContext.fetch(fetchRequest)
            if let existingBook = existingBooks.first {
                return existingBook.isSelected
            }
        } catch {
            print("Is book list error: \(error.localizedDescription)")
        }
        return false
    }
    
}
