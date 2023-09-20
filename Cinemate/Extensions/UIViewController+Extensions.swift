//
//  UIViewController+Extensions.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit
protocol IDataPickerDelegate: AnyObject {
    func didDataPicker(_ data: [String: Any])
}
extension UIViewController {
    private struct UniqueIdProperies {
        static var pickerDelegate: IDataPickerDelegate?
        static var previousViewController: UIViewController?
    }

    // MARK: - Picker Delegate Properties

    weak var dataPickerDelegate: IDataPickerDelegate? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.pickerDelegate) as? IDataPickerDelegate
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.pickerDelegate, unwrappedValue as IDataPickerDelegate?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
}
