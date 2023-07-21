//
//  AdminHomeDetailsTableViewCell.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/18/23.
//

import UIKit

class AdminHomeDetailsTableViewCell: UITableViewCell {

    static let identifier = "DriverDetailsTableViewCell"
    
    let clientName : UILabel = {
        var clientName = UILabel()
        clientName.font = UIFont.boldSystemFont(ofSize: 15)
        clientName.textAlignment = .center
        return clientName
    }()
    
    let clientAddress : UILabel = {
        var clientAddress = UILabel()
        clientAddress.textAlignment = .center
        return clientAddress
    }()
    
    let clientStackView: UIStackView = {
        var clientStack = UIStackView()
        clientStack.axis = .vertical
        clientStack.alignment = .fill
        clientStack.distribution = .fillEqually
        clientStack.spacing = 3
        return clientStack
    }()
    
    let specCollectedLabel : UILabel = {
        var specCollectedLabel = UILabel()
        specCollectedLabel.textAlignment = .center
        
        return specCollectedLabel
    }()
    
    let pickedUpAtTime : UILabel = {
        var pickedUpAt = UILabel()
        pickedUpAt.textAlignment = .center
        return pickedUpAt
    }()
    
    
    let noOfSpecLabel : UILabel = {
        var noOfSpecLabel = UILabel()
        noOfSpecLabel.textAlignment = .center
        return noOfSpecLabel
    }()
    
    
    let mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 5
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clientStackView.addArrangedSubview(clientName)
        clientStackView.addArrangedSubview(clientAddress)
        
        
        mainStackView.addArrangedSubview(clientStackView)
        mainStackView.addArrangedSubview(specCollectedLabel)
        mainStackView.addArrangedSubview(pickedUpAtTime)
        mainStackView.addArrangedSubview(noOfSpecLabel)
     
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
