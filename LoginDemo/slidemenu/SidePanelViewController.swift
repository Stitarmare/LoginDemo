//
//  SidePanelViewController.swift
//  LoginDemo
//
//  Created by saurabh titarmare on 21/11/18.
//  Copyright © 2018 saurabh titarmare. All rights reserved.
//

import UIKit

class SidePanelViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    let menuTile = ["Home","Profile","Setting"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
    }
    
}

extension SidePanelViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTile.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell else {
            fatalError()
        }
        cell.menuTitle.text = menuTile[indexPath.row]
        return cell
    }
}


extension SidePanelViewController: UITableViewDelegate{
    
}
