//
//  LoadingState.swift
//  Demo_mvvm
//
//  Created by Артем Романов on 28.04.2023.
//

import Foundation

enum LoadingState: Equatable {
    case loaded
    case loading
    
    var isLoading: Bool { self == .loading }
}
