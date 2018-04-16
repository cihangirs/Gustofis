//
//  TabView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 16/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit

class TabView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabIcon: UIImageView!
    @IBOutlet weak var tabTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TabView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
