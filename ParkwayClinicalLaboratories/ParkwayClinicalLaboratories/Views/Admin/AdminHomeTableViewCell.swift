//
//  AdminHomeTableViewCell.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/14/23.
//

import UIKit

import UIKit

class AdminHomeTableViewCell: UITableViewCell {
    static let identifier = "AdminHomeTableViewCell"
    
    let routeNoLabel : UILabel = {
        var route = UILabel()
        route.textAlignment = .center
        return route
    }()
    
    let routeNoTextLabel : UILabel = {
        var routeText = UILabel()
        routeText.textAlignment = .center
        return routeText
    }()
    
    let routeStackView: UIStackView = {
        var routeStack = UIStackView()
        routeStack.axis = .vertical
        routeStack.alignment = .fill
        routeStack.distribution = .fillEqually
        routeStack.spacing = 3
        return routeStack
    }()
    
    let accountStatusLabel : UILabel = {
        var accountStatus = UILabel()
        accountStatus.textAlignment = .center
        return accountStatus
    }()
    
    let accountStatusImage : UIImageView = {
        var statusImage = UIImageView()
        statusImage.image = UIImage(named: "greendot")
        statusImage.contentMode = .scaleAspectFit
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        return statusImage
    }()
    
    let accountStatusStackView: UIStackView = {
        var accountStack = UIStackView()
        accountStack.axis = .vertical
        accountStack.alignment = .fill
        accountStack.distribution = .fillEqually
        accountStack.spacing = 3
        return accountStack
    }()
    
    let pickedUpAtLabel : UILabel = {
        var pickedUpAt = UILabel()
        pickedUpAt.textAlignment = .center
        return pickedUpAt
    }()
    
    let pickedUpAtTime : UILabel = {
        var pickedUpAt = UILabel()
        pickedUpAt.textAlignment = .center
        return pickedUpAt
    }()
    
    let pickedUpAtStackView: UIStackView = {
        var pickedUpAtStack = UIStackView()
        pickedUpAtStack.axis = .vertical
        pickedUpAtStack.alignment = .fill
        pickedUpAtStack.distribution = .fillEqually
        pickedUpAtStack.spacing = 3
        return pickedUpAtStack
    }()
    
    let pickedUpByLabel : UILabel = {
        var pickedUpBy = UILabel()
        pickedUpBy.numberOfLines = 0
        pickedUpBy.textAlignment = .center
        return pickedUpBy
    }()
    
    let pickedUpByTextLabel : UILabel = {
        var pickedUpByText = UILabel()
        pickedUpByText.textAlignment = .center
       pickedUpByText.numberOfLines = 0
        return pickedUpByText
    }()
    
    let pickedUpByStackView: UIStackView = {
        var pickedUpByStack = UIStackView()
        pickedUpByStack.axis = .vertical
        pickedUpByStack.alignment = .fill
        pickedUpByStack.distribution = .fillEqually
        pickedUpByStack.spacing = 3
        return pickedUpByStack
    }()
    
    let specimenLabel : UILabel = {
        var specimen = UILabel()
        specimen.numberOfLines = 0
        specimen.textAlignment = .center
        return specimen
    }()
    
    let specimenTextLabel : UILabel = {
        var specimenText = UILabel()
        specimenText.textAlignment = .center
        return specimenText
    }()
    
    let specimenStackView: UIStackView = {
        var specimenStack = UIStackView()
        specimenStack.axis = .vertical
        specimenStack.alignment = .fill
        specimenStack.distribution = .fillEqually
        specimenStack.spacing = 3
        return specimenStack
    }()
    
    
    let allExceptOnTimeStackView: UIStackView = {
        var allExceptOnTimeStack = UIStackView()
        allExceptOnTimeStack.axis = .horizontal
        allExceptOnTimeStack.alignment = .fill
        allExceptOnTimeStack.distribution = .fillEqually
        allExceptOnTimeStack.spacing = 14
        return allExceptOnTimeStack
    }()
    
    let onTimeorNot : UILabel = {
        var onTime = UILabel()
        onTime.textAlignment = .center
        return onTime
    }()
    
    let homeButton: UIButton = {
        var home = UIButton()
        home.setTitle("Home", for: .normal)
        home.setTitleColor(UIColor(named: "Maroon"), for: .normal)
     //   home.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        return home
    }()
    
  
    
    
    let mainStackView: UIStackView = {
        var mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 1
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        routeStackView.addArrangedSubview(routeNoLabel)
        routeStackView.addArrangedSubview(routeNoTextLabel)
        
        accountStatusStackView.addArrangedSubview(accountStatusLabel)
        accountStatusStackView.addArrangedSubview(accountStatusImage)
        
        pickedUpAtStackView.addArrangedSubview(pickedUpAtLabel)
        pickedUpAtStackView.addArrangedSubview(pickedUpAtTime)
        
        pickedUpByStackView.addArrangedSubview(pickedUpByLabel)
        pickedUpByStackView.addArrangedSubview(pickedUpByTextLabel)
        
        specimenStackView.addArrangedSubview(specimenLabel)
        specimenStackView.addArrangedSubview(specimenTextLabel)
        
        allExceptOnTimeStackView.addArrangedSubview(routeStackView)
        allExceptOnTimeStackView.addArrangedSubview(accountStatusStackView)
        allExceptOnTimeStackView.addArrangedSubview(pickedUpAtStackView)
        allExceptOnTimeStackView.addArrangedSubview(pickedUpByStackView)
        allExceptOnTimeStackView.addArrangedSubview(specimenStackView)
        
        mainStackView.addArrangedSubview(allExceptOnTimeStackView)
        mainStackView.addArrangedSubview(onTimeorNot)
     
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate(
            [mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
             mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
//             onTimeorNot.widthAnchor.constraint(equalToConstant: 100),
             // accountStatusImage.widthAnchor.constraint(equalToConstant: 10)
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
