//
//  QRReaderView.swift
//  GustOfis
//
//  Created by Cihangir Sungur on 04/04/2018.
//  Copyright © 2018 Cihangir Sungur. All rights reserved.
//

import UIKit
import QRCodeReader

class QRReaderView: UIView {
    let cameraView: UIView            = UIView()
    let cancelButton: UIButton?       = UIButton()
    let switchCameraButton: UIButton? = SwitchCameraButton()
    let toggleTorchButton: UIButton?  = ToggleTorchButton()
    var overlayView: UIView?          = UIView()
    
    func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool) {
        // addSubviews
        // setup constraints
        // etc.
    }
}

//lazy var reader: QRCodeReaderViewController = {
//    let builder = QRCodeReaderViewControllerBuilder {
//        let readerView = QRCodeReaderContainer(displayable: QRReaderView())
//
//        $0.readerView = readerView
//    }
//
//    return QRCodeReaderViewController(builder: builder)
//}()

