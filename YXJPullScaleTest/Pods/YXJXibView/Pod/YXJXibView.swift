//
//  YXJXibView.swift
//  YXJXibView
//
//  Created by 袁晓钧 on 16/7/4.
//

import Foundation
import UIKit

public protocol NibDefinable {
    var nibName: String { get }
}

public extension NibDefinable {
    var nibName: String {
        return String(self.dynamicType)
    }
}

@objc public class YXJXibView: UIView, NibDefinable {

    @IBOutlet weak var view: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromXib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        backgroundColor = .clearColor()
        addSubview(view)
    }

    private func loadViewFromXib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        return view
    }
}