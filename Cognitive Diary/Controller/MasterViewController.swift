//
//  MasterViewControllerTableViewController.swift
//  Cognitive Diary
//
//  Created by Alberto Azzari on 02/10/2020.
//

import UIKit
import CoreData


protocol diaryModelSelectionDelegate: class
{
  func diaryModelSelected(_ newDiaryModel: DiaryModel)
}

protocol diaryModelSavedDelegate: class {
    func diaryModelSaved(_ diaryItemSaved: DiaryModel)
}

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
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    //MARK: - Override TABLE Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return diaryItems.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(rgbHexValue: "ffa726")
        } else {
            cell.backgroundColor = UIColor(rgbHexValue: "c77800")
        }
        
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
    
    //MARK: - Supporting Function

    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer)
    {
      guard let tabBarController = tabBarController, let viewControllers = tabBarController.viewControllers else { return }
      let tabs = viewControllers.count
      if gesture.direction == .left {
          if (tabBarController.selectedIndex) < tabs
          {
              tabBarController.selectedIndex += 1
          }
      }
      else if gesture.direction == .right
      {
          if (tabBarController.selectedIndex) > 0
          {
              tabBarController.selectedIndex -= 1
          }
      }
    }
}

extension MasterViewController: diaryModelSavedDelegate {
    func diaryModelSaved(_ diaryItemSaved: DiaryModel) {
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
}


