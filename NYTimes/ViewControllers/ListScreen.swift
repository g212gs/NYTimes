//
//  ListScreen.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit

class ListScreen: UITableViewController {

    var detailScreen: DetailScreen? = nil
    var objects = [Any]()

//    let operationsManager = OperationsManager.shared

    var currentOffset = 0
    var defaultSection = "all-sections"
    var defaultTimePeriod = TimePeriod.Week { didSet {
        refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        } }
    
    var mostPopularViewModel: MostPopularViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailScreen = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailScreen
        }
        
        // title
        self.title = "NY Times Most Popular"
        
        // Configure Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(ListScreen.refresh), for: UIControl.Event.valueChanged)
        
        refreshControl?.attributedTitle = NSAttributedString(string: self.getFetchingMessage())
        
        // Configure Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        
        // set view model
        mostPopularViewModel = MostPopularViewModel(operationsManager: OperationsManager.share)
        mostPopularViewModel?.currentOffset = self.currentOffset
        mostPopularViewModel?.defaultSection = self.defaultSection
        mostPopularViewModel?.defaultTimePeriod = self.defaultTimePeriod
        mostPopularViewModel?.delegate = self
        mostPopularViewModel?.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    func showError(message:String) {
    
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    private func getFetchingMessage() -> String {
        
        return "Fetching this \(self.defaultTimePeriod.getDisplayName())'s most viewed in \(self.defaultSection)"
    }
    
    @objc func refresh(sender:AnyObject) {
        
        self.currentOffset = 0
        mostPopularViewModel?.currentOffset = self.currentOffset
        mostPopularViewModel?.fetchData()
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailScreen
                if let dataSourceObjects = mostPopularViewModel?.dataSourceObjects {
                    controller.dataSourceObject = dataSourceObjects[indexPath.row]
                }
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailScreen = controller
            }
        }
    }

    // MARK: - Table View

    
}

// MARK: - UITableViewDataSource
extension ListScreen {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSourceObjects = mostPopularViewModel?.dataSourceObjects else {
            return 0
        }
        return dataSourceObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListScreenCell.self) , for: indexPath) as? ListScreenCell else {
            return UITableViewCell()
        }

        guard let dataSourceObjects = mostPopularViewModel?.dataSourceObjects else {
            return UITableViewCell()
        }
        let object = dataSourceObjects[indexPath.row]
        cell.bindData(object: object)
        return cell
    }

}

// MARK: - MostPopularViewModelDelegate
extension ListScreen: MostPopularViewModelDelegate {
    
    func SuccessRetrivingResult() {
        DispatchQueue.main.async {
            // Main thread implementation
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
             self.tableView.scrollToRow(at: IndexPath(row: self.currentOffset, section: 0), at: .bottom, animated: false)
        }
    }
    
    func FailureRetrivingResult(error msg: String) {
        self.showError(message: msg)
        self.refreshControl?.endRefreshing()
    }
}

