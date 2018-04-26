//
//  MovieView.swift
//  AsyncTesting
//
//  Created by C4Q on 4/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MovieView: UIView {

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "movieCell")
        
        return tv
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    private func setupViews() {
        self.backgroundColor = .green
       addSubview(tableView)
     tableView.translatesAutoresizingMaskIntoConstraints = false
       tableView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor).isActive = true
        
        
    }
   
}
