//
//  RouteParam.swift
//  Core
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import Foundation

public protocol RouteParam {}

public struct RouteByname: RouteParam {
    public var name: RouteName
    public var param: [String: Any]
    public var transitionType: SceneTransitionType
    public init(name: RouteName, param: [String: Any], transitionType: SceneTransitionType) {
        self.name = name
        self.param = param
        self.transitionType = transitionType
    }
}
