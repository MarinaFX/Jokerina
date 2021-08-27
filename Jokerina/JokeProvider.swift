//
//  JokeProvider.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 24/08/21.
//

import Foundation

struct JokeProvider {
    static var jokes: [Joke] = Joke.load("data.json")
    
    static func getJoke(by url: URL) -> Joke {
        return jokes.filter { joke in
            joke.url == url
        }.first!
    }
    
    static func all() -> [Joke] {
        return jokes.isEmpty ? Joke.load("data.json") : jokes
    }
    
    static func random() -> Joke {
        let allJokes = JokeProvider.all()
        let randomIndex = Int.random(in: 0..<allJokes.count)
        return allJokes[randomIndex]
    }
    
    static func shuffle(){
        jokes = jokes.shuffled()
    }
}
