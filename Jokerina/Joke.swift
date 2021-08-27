//
//  Joke.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 24/08/21.
//

import Foundation
import Combine

struct Joke: Hashable, Codable, Identifiable {
    var id: Int
    var question: String
    var answer: String
    let url: URL?
    
    init(id: Int, question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
        self.url = URL(string: "joke://\(id)")
      }

    static func load<T: Decodable> (_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
