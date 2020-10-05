//
//  ABCViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit

class ABCViewController: UITableViewController {

    //MARK: - Instance Variables
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var aTextView: UITextView!
    
    @IBOutlet weak var bTextView: UITextView!
    
    @IBOutlet weak var cTextView: UITextView!
    
    let screenHeigth = UIScreen.main.bounds.height
    
    //MARK: - Override VIEW Functions
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        titleTextField.text = ""
        titleTextField.placeholder = generateTitle()
        aTextView.text = ""
        bTextView.text = ""
        cTextView.text = ""
        aTextView.placeholder = "Type your thoughts"
        bTextView.placeholder = "Type your thoughts"
        cTextView.placeholder = "Type your thoughts"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //invisible empty cell
        tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        if( aTextView.text != "" && bTextView.text != "" && cTextView.text != "" )
        {
            createAndSaveDiaryItem()
        }
    }
    
    //MARK: - Override TABLE Functions
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (indexPath.row == 0 ||  indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5)
        {
            return screenHeigth*0.05
        }
        else
        {
            return screenHeigth*0.20
        }
    }
        
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    //MARK: - Supporting Function
    
    private func createAndSaveDiaryItem()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = DiaryModel.createEntity(in_context: managedContext)!
        let diaryItem =  DiaryModel(entity: entity, insertInto: managedContext)
        if let text = titleTextField.text, text.isEmpty
        {
            titleTextField.text = titleTextField.placeholder
        }
        diaryItem.title = titleTextField.text
        diaryItem.a = aTextView.text
        diaryItem.b = bTextView.text
        diaryItem.c = cTextView.text
        diaryItem.date = Date()
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func generateTitle() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let result = formatter.string(from: date)
        return "New ABC Notes - " + result
    }
    
    @objc private func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification)
    {
        tableView.contentInset = .zero
    }
}
