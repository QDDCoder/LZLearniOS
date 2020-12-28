//
//  UIView_Animation+Extension.swift
//  sdxf
//
//  Created by 湛亚磊 on 2020/1/11.
//  Copyright © 2020 湛亚磊. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
extension Reactive where Base == UIView {
    func rotate(duration: TimeInterval) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            UIView.animate(withDuration: duration, animations: {
                self.base.transform = CGAffineTransform(rotationAngle: .pi/2)
            }, completion: { _ in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func shift(duration: TimeInterval) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            UIView.animate(withDuration: duration, animations: {
                self.base.frame = self.base.frame.offsetBy(dx: 50, dy: 0)
            }, completion: { (_) in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }

    func fade(duration: TimeInterval) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            UIView.animate(withDuration: duration, animations: {
                self.base.alpha = 0
            }, completion: { (_) in
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }

    func rotateEndlessly(duration: TimeInterval) -> Observable<Void> {
        var disposed = false
        return Observable.create { (observer) -> Disposable in
            func animate() {
                UIView.animate(withDuration: duration, animations: {
                    self.base.transform = self.base.transform.rotated(by: .pi/2)
                }, completion: { (_) in
                    observer.onNext(())
                    if !disposed {
                        animate()
                    }
                })
            }
            animate()
            return Disposables.create {
                disposed = true
            }
        }
    }
}
