//
//  DetailViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var aTextView: UITextView!
    
    @IBOutlet weak var bTextView: UITextView!
    
    @IBOutlet weak var cTextView: UITextView!
    
    
    var diaryItem : DiaryModel?
    {
        didSet
        {
            refreshUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initializeHideKeyboard()
    
    }
    private func refreshUI()
    {
        loadViewIfNeeded()
        titleTextField.text = diaryItem?.title
        
        aTextView.text = diaryItem?.a
        bTextView.text = diaryItem?.b
        cTextView.text = diaryItem?.c
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveDiaryItem(_ sender: UIButton)
    {
        if let text = titleTextField.text, text.isEmpty
        {
            titleTextField.text = titleTextField.placeholder
        }
        diaryItem?.title = titleTextField.text
        
        diaryItem?.a = aTextView.text
        diaryItem?.b = bTextView.text
        diaryItem?.c = cTextView.text

    }
    
    private func generateTitle() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let result = formatter.string(from: date)
        
        return "New ABC Notes - " + result
    }
}

extension DetailViewController: diaryModelSelectionDelegate
{
  func diaryModelSelected(_ newDiaryModel: DiaryModel) {
    diaryItem = newDiaryModel
  }
}
extension DetailViewController {
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
}
