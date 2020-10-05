//
//  MasterViewControllerTableViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController
{
    //MARK: - Instance Variables
    
    var diaryItems: [DiaryModel] = []
    weak var delegate: diaryModelSelectionDelegate?

    //MARK: - Override VIEW Functions
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        do
        {
            diaryItems = try DiaryModel.fetchData() ?? []
            tableView.reloadData()
        }
        catch let error as NSError
        {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK: - Override TABLE Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return diaryItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let diaryItem = diaryItems[indexPath.row]
        cell.textLabel?.text = diaryItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedDiaryModel = diaryItems[indexPath.row]
        delegate?.diaryModelSelected(selectedDiaryModel)
        if let detailViewController = delegate as? DetailViewController
        {
          splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
}

protocol diaryModelSelectionDelegate: class
{
  func diaryModelSelected(_ newDiaryModel: DiaryModel)
}

