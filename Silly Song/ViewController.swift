//
//  ViewController.swift
//  Silly Song
//
//  Created by Marc Boanas on 02/03/2017.
//  Copyright © 2017 Marc Boanas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = UITextAutocapitalizationType.sentences
        nameField.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if let name = nameField.text {
            if name != "" {
                lyricsView.text = lyricsForName(lyricsTemplate: bananaTemplate, fullName: name)
            }
        }
    }
}

func shortNameFromName(name: String) -> String {
    let vowelSet: CharacterSet = CharacterSet(charactersIn: "aeiou")
    let lowercaseName = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
    let range = lowercaseName.rangeOfCharacter(from: vowelSet)
    return lowercaseName.substring(from: range!.lowerBound)
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName: String = shortNameFromName(name: fullName)
    let lyrics = lyricsTemplate.replacingOccurrences(of: "<SHORT_NAME>", with: shortName).replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    return lyrics
}

let bananaTemplate = ["<FULL_NAME>, <FULL_NAME>, BO B<SHORT_NAME>", "Banana Fana Fo F<SHORT_NAME>", "Me My Mo M<SHORT_NAME>", "<FULL_NAME>"].joined(separator: "\n")

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
