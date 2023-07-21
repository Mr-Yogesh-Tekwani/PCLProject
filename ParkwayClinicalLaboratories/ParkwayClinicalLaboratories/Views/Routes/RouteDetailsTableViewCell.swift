//
//  RouteDetailsTableViewCell.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//

import UIKit

class RouteDetailsTableViewCell: UITableViewCell {

    static let identifier = "RouteDetailsTableViewCell"
    
    let routeIdLabel : UILabel = {
        var routeIdLabel = UILabel()
        routeIdLabel.font = UIFont.boldSystemFont(ofSize: 15)
        routeIdLabel.textAlignment = .center
        return routeIdLabel
    }()
    
    let routeId : UILabel = {
        var routeId = UILabel()
        routeId.textAlignment = .center
        return routeId
    }()
    
    let routeStackView: UIStackView = {
        var routeStack = UIStackView()
        routeStack.axis = .vertical
        routeStack.alignment = .fill
        routeStack.distribution = .fillEqually
        routeStack.spacing = 3
        return routeStack
    }()
    
    
    let routeNameLabel : UILabel = {
        var routeIdLabel = UILabel()
        routeIdLabel.font = UIFont.boldSystemFont(ofSize: 15)
        routeIdLabel.textAlignment = .center
        return routeIdLabel
    }()
    
    let routeName : UILabel = {
        var routeId = UILabel()
        routeId.textAlignment = .center
        return routeId
    }()
    
    let routeNameStackView: UIStackView = {
        var routeStack = UIStackView()
        routeStack.axis = .vertical
        routeStack.alignment = .fill
        routeStack.distribution = .fillEqually
        routeStack.spacing = 3
        return routeStack
    }()
    
    
    let driverNameLabel : UILabel = {
        var routeIdLabel = UILabel()
        routeIdLabel.font = UIFont.boldSystemFont(ofSize: 15)
        routeIdLabel.textAlignment = .center
        return routeIdLabel
    }()
    
    let driverName : UILabel = {
        var routeId = UILabel()
        routeId.textAlignment = .center
        return routeId
    }()
    
    let driverNameStackView: UIStackView = {
        var routeStack = UIStackView()
        routeStack.axis = .vertical
        routeStack.alignment = .fill
        routeStack.distribution = .fillEqually
        routeStack.spacing = 3
        return routeStack
    }()
    
    let mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fillEqually
//        mainStack.spacing = 5
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        routeStackView.addArrangedSubview(routeIdLabel)
        routeStackView.addArrangedSubview(routeId)
        
        routeNameStackView.addArrangedSubview(routeNameLabel)
        routeNameStackView.addArrangedSubview(routeName)
        
        driverNameStackView.addArrangedSubview(driverNameLabel)
        driverNameStackView.addArrangedSubview(driverName)
        
        
        mainStackView.addArrangedSubview(routeStackView)
        mainStackView.addArrangedSubview(routeNameStackView)
        mainStackView.addArrangedSubview(driverNameStackView)
     
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
