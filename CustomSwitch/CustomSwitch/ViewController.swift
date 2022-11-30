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
    
    let customYesNoSwitch : CustomUISwitch = {
        let customSwitch = CustomUISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = UIColor(red: 42.0/255.0, green: 187.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        customSwitch.offTintColor = UIColor(red: 251.0/255.0, green: 88.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        customSwitch.cornerRadius = 1.0

        customSwitch.padding = 5
        customSwitch.thumbCornerRadius = 1.0
        customSwitch.thumbTintColor = UIColor.white
        customSwitch.thumbSize = CGSize(width: 38, height: 38)
        customSwitch.animationDuration = 1.0
        
        customSwitch.onImage = UIImage(named: "yesImage")?.withRenderingMode(.alwaysTemplate)
        customSwitch.onImageView.tintColor = UIColor(red: 42.0/255.0, green: 187.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        customSwitch.offImage = UIImage(named: "noImage")?.withRenderingMode(.alwaysTemplate)
        customSwitch.offImageView.tintColor = UIColor(red: 251.0/255.0, green: 88.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        return customSwitch
    }()
    
    let customLightDarkSwitch : CustomUISwitch = {
        let customSwitch = CustomUISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = UIColor(red: 28.0/255.0, green: 24.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        customSwitch.offTintColor = .systemGray4
        customSwitch.cornerRadius = 0.2

        customSwitch.thumbCornerRadius = 0.2
        customSwitch.thumbTintColor = UIColor.white
        customSwitch.animationDuration = 1.0
        customSwitch.thumbSize = CGSize(width: 100, height: 48)
        
        return customSwitch
    }()
    
    let customBiggerThumbSwitch : CustomUISwitch = {
        let customSwitch = CustomUISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.onTintColor = .purple
        customSwitch.offTintColor = .lightGray
        customSwitch.cornerRadius = 1.0

        customSwitch.padding = -1
        customSwitch.thumbCornerRadius = 1.0
        customSwitch.onThumbColor = UIColor(red: 203.0/255.0, green: 195.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        customSwitch.thumbSize = CGSize(width: 60, height: 60)
        customSwitch.animationDuration = 1.0
        customSwitch.thumbImage = UIImage(named: "logo_noBG")
        return customSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initConstraint()
        customSwitch.isOn = false
        customYesNoSwitch.isOn = false
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
        
        view.addSubview(customYesNoSwitch)
        customYesNoSwitch.translatesAutoresizingMaskIntoConstraints = false
        customYesNoSwitch.topAnchor.constraint(equalTo: customSwitch.bottomAnchor, constant: 10).isActive = true
        customYesNoSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        customYesNoSwitch.widthAnchor.constraint(equalToConstant: 120).isActive = true
        customYesNoSwitch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(customLightDarkSwitch)
        customLightDarkSwitch.translatesAutoresizingMaskIntoConstraints = false
        customLightDarkSwitch.topAnchor.constraint(equalTo: customYesNoSwitch.bottomAnchor, constant: 10).isActive = true
        customLightDarkSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        customLightDarkSwitch.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customLightDarkSwitch.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(customBiggerThumbSwitch)
        customBiggerThumbSwitch.translatesAutoresizingMaskIntoConstraints = false
        customBiggerThumbSwitch.topAnchor.constraint(equalTo: customLightDarkSwitch.bottomAnchor, constant: 10).isActive = true
        customBiggerThumbSwitch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        customBiggerThumbSwitch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customBiggerThumbSwitch.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

}

