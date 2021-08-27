//
//  ViewController.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 24/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstJoke: Joke = JokeProvider.random()
        
        SmallJokeWidgetView.delegate = self
        
        questionLabel.text = firstJoke.question
        answerLabel.text = firstJoke.answer
        
        backgroundView.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        let joke = JokeProvider.random()
        
        questionLabel.text = joke.question
        answerLabel.text = joke.answer
        
        JokeProvider.shuffle()
    }
    
}

extension ViewController: JokeWidgetDelegate {
    
    func onOpenUrl(with url: URL) {
        let joke = JokeProvider.getJoke(by: url)
        
        questionLabel.text = joke.question
        answerLabel.text = joke.answer
    }
}
