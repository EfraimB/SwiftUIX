//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

var _areAnimationsDisabled: Bool = false

public func withoutAnimation(_ body: () -> ()) {
    #if os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst)
    CATransaction.begin()
    CATransaction.disableActions()
    #endif
    
    _areAnimationsDisabled = true
    
    withAnimation(.none) {
        body()
    }
    
    DispatchQueue.main.async {
        _areAnimationsDisabled = false
    }
    
    #if os(iOS) || os(macOS) || os(tvOS) || targetEnvironment(macCatalyst)
    CATransaction.commit()
    #endif
}
