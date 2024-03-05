//
//  ViewController.swift
//  EvidenciaiOS1
//
//  Created by Maricarmen Pedro on 02/03/24.
//

import UIKit

class ViewController: UIViewController {
    var totalWins = 0 {
        didSet {
                newRound()
            }
    }
    var totalLosses = 0 {
        didSet {
                newRound()
            }
    }
    let incorrectMovesAllowed = 7
    var currentGame: Game!
    var listOfWords = ["perro", "gato", "koala", "iguana", "leon", "mono", "panda"];

    

    @IBOutlet weak var treeImageView: UIImageView!
    
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration?.title ?? ""
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()

    }
    
    func updateGameState() {
      if currentGame.incorrectMovesRemaining == 0 {
        totalLosses += 1
      } else if currentGame.word == currentGame.formattedWord {
        totalWins += 1
      } else {
        updateUI()
      }
    }
    
   
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
            incorrectMovesRemaining: incorrectMovesAllowed,
            guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
        button.isEnabled = enable
      }
    }
    

    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

}
