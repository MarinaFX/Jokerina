//
//  IntentHandler.swift
//  JokeIntent
//
//  Created by Marina De Pazzi on 25/08/21.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
extension IntentHandler: SelectJokeIntentHandling {
    
    func provideJokeOptionsCollection(
        for intent: SelectJokeIntent,
        with completion: @escaping (INObjectCollection<JokeINO>?, Error?) -> Void
    ) {
        var jokeItems = [JokeINO]()
        JokeProvider.all().forEach { joke in
            let jokeIntentObject =
                JokeINO(identifier: String(joke.id), display: "\(joke.question)")
            jokeItems.append(jokeIntentObject)
        }
        completion(INObjectCollection(items: jokeItems), nil)
    }
}
