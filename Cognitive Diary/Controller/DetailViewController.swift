//
//  DetailViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit

class DetailViewController: UITableViewController
{
    //MARK: - Instance Variables
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var aTextView: UITextView!
    
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var bTextView: UITextView!
    
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var cTextView: UITextView!
    
    let screenHeigth = UIScreen.main.bounds.height
    
    var diaryItem : DiaryModel?
    {
        didSet
        {
            refreshUI()
        }
    }
    
    //MARK: - Override VIEW Functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        //invisible empty cell
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        saveDiaryItem()
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

    private func refreshUI()
    {
        loadViewIfNeeded()
        titleTextField.text = diaryItem?.title
        aTextView.text = diaryItem?.a
        bTextView.text = diaryItem?.b
        cTextView.text = diaryItem?.c
    }
    
    private func saveDiaryItem()
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

extension DetailViewController: diaryModelSelectionDelegate
{
  func diaryModelSelected(_ newDiaryModel: DiaryModel)
  {
    diaryItem = newDiaryModel
  }
}

