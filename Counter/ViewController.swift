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
        data.dateStyle = .short
        data.timeStyle = .short
        data.locale = Locale(identifier: "ru_RU")
        
        if let _ = UserDefaults.standard.string(forKey: "historyInput") {
            historyInput.text = UserDefaults.standard.string(forKey: "historyInput")
        } else {
            historyInput.text = "История изменений:\n"
        }
        textViewToBottom()
        counter = UInt(UserDefaults.standard.integer(forKey: "counter"))
        updateCounter()
    }
    
    private func textViewToBottom() {
        historyInput.scrollRangeToVisible(NSMakeRange(historyInput.text.count - 1, 1))
    }
    private func updateCounter() {
        counterLabel.text = String(counter)
        UserDefaults.standard.set(counter, forKey: "counter")
    }
    private func updateText() {
        UserDefaults.standard.set(historyInput.text, forKey: "historyInput")
        textViewToBottom()
    }
    private func currentDateAndTime() -> String {
        let date = Date()
        return data.string(from: date)
    }
    
    @IBAction private func incrementTap(_ sender: Any) {
        counter += 1
        historyInput.text.append("\(currentDateAndTime()): значение изменено на +1\n")
        updateText()
        updateCounter()
    }
    @IBAction private func decrementTap(_ sender: Any) {
        if counter != 0 {
            counter -= 1
            historyInput.text.append("\(currentDateAndTime()): значение изменено на -1\n")
        } else {
            historyInput.text.append("\(currentDateAndTime()): попытка уменьшить значение счетчика ниже 0\n")
        }
        updateText()
        updateCounter()
    }
    @IBAction private func resetCounterTap(_ sender: Any) {
        counter = 0
        historyInput.text.append("\(currentDateAndTime()): значение сброшено\n")
        updateText()
        updateCounter()
    }
}

