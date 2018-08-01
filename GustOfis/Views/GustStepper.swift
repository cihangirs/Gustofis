//
//  GustStepper.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 31.07.2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

protocol GustStepperDelegate {
    func didStepperCountChanged(value: Int)
}

class GustStepper: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stepperText: UILabel!
    
    weak var delegate: ProductsTableViewCell?
    var _stepperCount: Int = 1
    
    static let STEPPER_MIN_VALUE = 1
    static let STEPPER_MAX_VALUE = 10

    var stepperCount: Int {
        get {
            return self._stepperCount
        }
        set {
            self._stepperCount = newValue
            self.stepperText.text = "\(newValue)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GustStepper", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func decreaseButtonTapped(_ sender: Any) {
        if self.stepperCount > GustStepper.STEPPER_MIN_VALUE
        {
            self.stepperCount = self.stepperCount - 1
            self.stepperText.text = "\(self.stepperCount)"
            self.delegate?.didStepperCountChanged(value: self.stepperCount)
        }
    }
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        if self.stepperCount < GustStepper.STEPPER_MAX_VALUE
        {
            self.stepperCount = self.stepperCount + 1
            self.stepperText.text = "\(self.stepperCount)"
            self.delegate?.didStepperCountChanged(value: self.stepperCount)
        }
    }
}
