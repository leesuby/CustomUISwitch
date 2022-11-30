//
//  ViewController.swift
//  CustomSwitch
//
//  Created by LAP15335 on 28/11/2022.
//

import UIKit

class ViewController: UIViewController {

    let customSwitch : CustomUISwitch = {
        let customSwitch = CustomUISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = UIColor.purple
        customSwitch.offTintColor = UIColor.lightGray
        customSwitch.cornerRadius = 1.0

        customSwitch.padding = 3
        customSwitch.thumbCornerRadius = 1.0
        customSwitch.thumbTintColor = UIColor.white
        customSwitch.thumbSize = CGSize(width: 45, height: 45)
        customSwitch.animationDuration = 1.0

        let colorLeft =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let grayLeft = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 1.0).cgColor
        let grayRight = UIColor(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1.0).cgColor
        
        customSwitch.onGradientTintColor = [colorLeft,colorRight]
        customSwitch.offGradientTintColor = [grayLeft,grayRight]
        customSwitch.isGradient = true
        
        customSwitch.areLabelsShown = true
        
        return customSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initConstraint()
        customSwitch.isOn = false
    }
    
    func initView(){
        view.backgroundColor = .white
    }
    
    func initConstraint(){
        view.addSubview(customSwitch)
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        customSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        customSwitch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customSwitch.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}

