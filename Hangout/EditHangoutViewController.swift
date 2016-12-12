//
//  HangoutEditViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 12/6/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import UIKit

class EditHangoutViewController: UIViewController {

    var group: Group? = nil

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!

    @IBAction func doneButtonAction(_ sender: Any) {
        if (nameTextField.text?.isEmpty)! {
            nameView.backgroundColor = UIColor.red
        }
        else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let hangout = Hangout(context: context)
            hangout.initData(group!, name: nameTextField.text!, location: locationTextField.text!, date: dateTextField.text!, time: timeTextField.text!, desc: descTextView.text!)

            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            performSegue(withIdentifier: "unwindToGroupView", sender: sender)
        }
    }

    var isPlaceholderActive = true

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        descTextView.delegate = self

        setupViews()
    }

    func setupViews() {
        descTextView.text = "Add a description"
        descTextView.textColor = UIColor.lightGray
        descTextView.textContainerInset = UIEdgeInsets.zero
    }
}

extension EditHangoutViewController: UITextViewDelegate {

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView == nameView {
//            print("is name view")
//            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//            let charNum = newText.characters.count
//            return charNum < 15
//        }
//        print("not name view")
//        return true
//    }

    func textViewDidChange(_ textView: UITextView) {
        if textView === descTextView && isPlaceholderActive {
            textView.textColor = UIColor.black
            let char = textView.text.characters.first
            textView.text = ""
            textView.text.append(char!)

            isPlaceholderActive = false
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView === descTextView {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView === descTextView && textView.text.isEmpty {
            descTextView.text = "Add a description"
            descTextView.textColor = UIColor.lightGray
            isPlaceholderActive = true
        }
    }
}

extension EditHangoutViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let charNum = newText.characters.count
            return charNum < 25
        }
        return true
    }
}
