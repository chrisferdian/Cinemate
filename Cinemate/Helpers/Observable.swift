//
//  Observable.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 18/09/23.
//
import Foundation
class Observable<T> {
    typealias Observer = (T) -> Void
    
    var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(observer: @escaping Observer) {
        self.observer = observer
        observer(value)
    }
}
