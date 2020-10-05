//
//  SplitViewController.swift
//  iOSLib Package
//
//  Created by Richard Aurbach on 9/20/2017.
//  Updated for iOS 14 on 8/25/2020.
//  Copyright © 2017 Richard L. Aurbach. All rights reserved.
//

import Foundation
import UIKit

class MasterDetailViewController : UISplitViewController
{
    //MARK: - Override VIEW Functions
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.delegate = self
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            preferredDisplayMode = .oneBesideSecondary
            if #available(iOS 14, *)
            {
                preferredSplitBehavior = .tile
            }
        }
    }
}
extension MasterDetailViewController : UISplitViewControllerDelegate
{
    //Start App with MasterViewController instead of DetailViewController
    @available(iOS 14.0, *)
    public func splitViewController(_ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn
        proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column
    {
        return .primary
    }

    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController:UIViewController,
                             onto primaryViewController:UIViewController) -> Bool
    {
        return true
    }
}
