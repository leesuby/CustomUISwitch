////
////  CustomSwitch.swift
////  CustomSwitch
////
////  Created by LAP15335 on 28/11/2022.
////

import Foundation
import UIKit

public class CustomUISwitch: UIControl {
    
    //MARK: Public property
    var isOn: Bool = false
    var isGradient: Bool = false{
        didSet{
            self.setUpOnOffGradient()
        }
    }
    var animationDuration: Double = 0.5
    
    var padding: CGFloat = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return self.privateCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
        
    }
    
    var privateCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    //MARK: THUMB
    var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    var thumbCornerRadius: CGFloat {
        get {
            return self.privateThumbCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    var thumbSize: CGSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    var thumbImage: UIImage? = nil {
        didSet {
            guard let image = thumbImage else {
                return
            }
            thumbView.thumbImageView.image = image
        }
    }
    
    //MARK: ON-OFF
    var onImage: UIImage? {
        didSet {
            self.onImageView.image = onImage
            self.layoutSubviews()
        }
    }
    
    var offImage: UIImage? {
        didSet {
            self.offImageView.image = offImage
            self.layoutSubviews()
        }
    }
    
    var onTintColor: UIColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1) {
        didSet {
            self.setupUI()
            
        }
    }
    var offTintColor: UIColor = UIColor.black {
        didSet {
            self.setupUI()
        }
    }
    
    var onGradientTintColor: [CGColor] = [] {
        didSet{
            self.setupUI()
        }
    }
    
    var offGradientTintColor: [CGColor] = [] {
        didSet{
            self.setupUI()
        }
    }
    
    var onThumbColor: UIColor = .white {
        didSet{
            self.setupUI()
        }
    }
    
    var offThumbColor: UIColor = .white{
        didSet{
            self.setupUI()
        }
    }
    
    var labelOff: UILabel = UILabel(){
        didSet{
            self.setupUI()
        }
    }
    
    var labelOn: UILabel = UILabel(){
        didSet{
            self.setupUI()
        }
    }
    var areLabelsShown: Bool = false {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: Private properties
    fileprivate var gradientLayer = CAGradientLayer()
    fileprivate var POSITION_GRADIENT_LAYER : Int = 0
    
    fileprivate var thumbView = CustomThumbView(frame: CGRect.zero)
    
    var onImageView = UIImageView(frame: CGRect.zero)
    var offImageView = UIImageView(frame: CGRect.zero)
    
    fileprivate var onPoint = CGPoint.zero
    fileprivate var offPoint = CGPoint.zero
    
    fileprivate var isAnimating = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
}

// MARK: Private methods
extension CustomUISwitch {
    
    fileprivate func setupUI() {
        
        // clear before configuration
        self.clear()
        
        self.clipsToBounds = false
        
        self.thumbView.backgroundColor = self.isOn ? self.onThumbColor : self.offThumbColor
        self.thumbView.isUserInteractionEnabled = false
        self.thumbView.layer.shadowColor = UIColor.black.cgColor
        self.thumbView.layer.shadowRadius = 1.5
        self.thumbView.layer.shadowOpacity = 0.2
        self.thumbView.layer.shadowOffset = CGSize(width: 0.75, height: 2)
        
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
    
        self.addSubview(self.thumbView)
        self.addSubview(self.onImageView)
        self.addSubview(self.offImageView)
        
        self.setupLabels()
    }
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    func setOn(on:Bool) {
        self.animate(on: on)
    }
    
    fileprivate func animate(on:Bool? = nil) {
        self.isOn = on ?? !self.isOn
        
        self.isAnimating = true
        
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
        }, completion: { _ in
            self.completeAction()
            
        })
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.thumbView.backgroundColor = self.isOn ? self.onThumbColor : self.offThumbColor
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        self.gradientLayer.colors = self.isOn ? self.onGradientTintColor : self.offGradientTintColor
        
        //Setup Image
        guard onImage != nil && offImage != nil else {
            return
        }
        
        self.onImageView.center.x = self.isOn ? self.onPoint.x + self.thumbView.frame.size.width / 2 : self.frame.width
        self.offImageView.center.x = !self.isOn ? self.offPoint.x + self.thumbView.frame.size.width / 2 : 0
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
    }
    
    private func completeAction() {
        self.isAnimating = false
    }
    
}

// MARK: Public methods
extension CustomUISwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!self.isAnimating) {
            
            self.gradientLayer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.layer.backgroundColor = (self.isOn ? self.onTintColor : self.offTintColor).cgColor
            
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 2, height: self.bounds.height - 2)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            self.thumbView.backgroundColor = self.isOn ? self.onThumbColor : self.offThumbColor
            
            //label frame
            if self.areLabelsShown {
                let labelWidth = self.bounds.width / 2 - self.padding * 2
                self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
                self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            }
            
            setUpOnOffGradient()
            
            setUpOnOffImage()
        }
    }
    
    
    func setUpOnOffGradient(){
        if(!isGradient){
            if(checkExistGradientLayer()){
                self.layer.sublayers?.remove(at: 0)
            }
        }else{
            if(!checkExistGradientLayer()){
                self.layer.insertSublayer(self.gradientLayer, at: 0)
            }
            self.gradientLayer.colors = self.isOn ? self.onGradientTintColor : self.offGradientTintColor
            self.gradientLayer.frame = bounds
        }
    }
    
    func setUpOnOffImage(){
        guard onImage != nil && offImage != nil else {
            return
        }
        
        let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
        
        let onOffImageSize = CGSize(width: frameSize, height: frameSize)
        
        self.onImageView.frame.size = onOffImageSize
        self.offImageView.frame.size = onOffImageSize
        
        self.onImageView.center = CGPoint(x: self.onPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
        self.offImageView.center = CGPoint(x: self.offPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
        
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
    }
    
    func checkExistGradientLayer() -> Bool{
        guard let subLayers = layer.sublayers else{
            return false
        }
        
        if(!subLayers.isEmpty){
            if(subLayers[0] is CAGradientLayer){
                return true
            }
        }
        return false
        
    }
}

//MARK: Label
extension CustomUISwitch {
    
    fileprivate func setupLabels() {
        guard self.areLabelsShown else {
            self.labelOff.alpha = 0
            self.labelOn.alpha = 0
            return
            
        }
        
        self.labelOff.alpha = 1
        self.labelOn.alpha = 1
        
        let labelWidth = self.bounds.width / 2 - self.padding * 2
        self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOff.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        self.labelOn.font = UIFont.boldSystemFont(ofSize: 12)
        self.labelOff.font = UIFont.boldSystemFont(ofSize: 12)
//        self.labelOn.textColor = UIColor.white
//        self.labelOff.textColor = UIColor.white
        
        self.labelOff.sizeToFit()
//        self.labelOff.text = "OFF"
//        self.labelOn.text = "ON"
        self.labelOff.textAlignment = .center
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOff, belowSubview: self.thumbView)
        self.insertSubview(self.labelOn, belowSubview: self.thumbView)
        
    }
    
}
