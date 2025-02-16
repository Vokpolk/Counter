//
//  ViewController.swift
//  Counter
//
//  Created by Александр Клопков on 14.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    private var counter: UInt = 0
    private var data: DateFormatter = DateFormatter()
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var historyInput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        historyInput.text = "История изменений:\n"
        updateCounter()
        
        data.dateStyle = .short
        data.timeStyle = .short
        data.locale = Locale(identifier: "ru_RU")
    }
    
    private func textViewToBottom() {
        historyInput.scrollRangeToVisible(NSMakeRange(historyInput.text.count - 1, 1))
    }
    private func updateCounter() {
        counterLabel.text = String(counter)
    }
    private func currentDateAndTime() -> String {
        let date = Date()
        return data.string(from: date)
    }
    
    @IBAction private func incrementTap(_ sender: Any) {
        counter += 1
        historyInput.text.append("\(currentDateAndTime()): значение изменено на +1\n")
        textViewToBottom()
        updateCounter()
    }
    @IBAction private func decrementTap(_ sender: Any) {
        if counter != 0 {
            counter -= 1
            historyInput.text.append("\(currentDateAndTime()): значение изменено на -1\n")
        } else {
            historyInput.text.append("\(currentDateAndTime()): попытка уменьшить значение счетчика ниже 0\n")
        }
        textViewToBottom()
        updateCounter()
    }
    @IBAction private func resetCounterTap(_ sender: Any) {
        counter = 0
        historyInput.text.append("\(currentDateAndTime()): значение сброшено\n")
        textViewToBottom()
        updateCounter()
    }
}

