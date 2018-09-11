//
//  BookController.swift
//  Reading List
//
//  Created by Madison Waters on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return directory.appendingPathComponent("books.plist")
    }
    
    // Filter for HasBeenRead Property
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return directory.appendingPathComponent("books.plist")
    }

    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        
        } catch {
            NSLog("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: data)
            
        } catch {
            NSLog("Error reading books data: \(error)")
        }
    }
    
    //////// CRUD Functions ////////
    //Read
    private(set) var books: [Book] = []
    
    //Create
    func createBook (title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
    }
    
    // Update
    func updateBook(book: Book, title: String, reasonToRead: String, hasBeenRead: Bool) {
        guard let index = books.index(of: book) else { return }
        
        var scratch = updateBook
        
        scratch.Book = book
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        scratch.hasBeenRead = hasBeenRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
        
        // return statement needed?
    }
    
    func updateHasBeenRead(book: Book) {
        book.hasBeenRead = !book.hasBeenRead
    }
    
    // Delete
    func deleteBook (book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        
    }
    
}
