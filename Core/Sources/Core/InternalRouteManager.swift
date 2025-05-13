//
//  InternalRouteManager.swift
//  Core
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import Combine

public protocol InternalRouteManagerType {
    var openRoute: PassthroughSubject<RouteParam, Never> { get }
}

public final class InternalRouteManager: InternalRouteManagerType, @unchecked Sendable {
    public static let shared: InternalRouteManager = .init()
    public let openRoute: PassthroughSubject<RouteParam, Never> = .init()
}
