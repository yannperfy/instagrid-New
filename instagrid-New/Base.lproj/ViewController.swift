//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var soustractionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var egalButtopon: UIButton!
    @IBOutlet weak var deleteBoutton: UIButton!
    @IBOutlet weak var zeroBoutton: UIButton!
    @IBOutlet weak var unBoutton: UIButton!
    @IBOutlet weak var deuxBoutton: UIButton!
    @IBOutlet weak var troisBoutton: UIButton!
    @IBOutlet weak var quatreBoutton: UIButton!
    @IBOutlet weak var cinqBoutton: UIButton!
    @IBOutlet weak var sixBoutton: UIButton!
    @IBOutlet weak var setpBoutton: UIButton!
    @IBOutlet weak var huitBoutton: UIButton!
    @IBOutlet weak var neufBoutton: UIButton!
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        additionButton.layer.cornerRadius = 6
        soustractionButton.layer.cornerRadius = 6
        multiplicationButton.layer.cornerRadius = 6
        divisionButton.layer.cornerRadius = 6
        egalButtopon.layer.cornerRadius = 6
        deleteBoutton.layer.cornerRadius = 6
        zeroBoutton.layer.cornerRadius = 6
        unBoutton.layer.cornerRadius = 6
        deuxBoutton.layer.cornerRadius = 6
        troisBoutton.layer.cornerRadius = 6
        quatreBoutton.layer.cornerRadius = 6
        cinqBoutton.layer.cornerRadius = 6
        sixBoutton.layer.cornerRadius = 6
        setpBoutton.layer.cornerRadius = 6
        huitBoutton.layer.cornerRadius = 6
        neufBoutton.layer.cornerRadius = 6
        textView.layer.cornerRadius = 15
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

