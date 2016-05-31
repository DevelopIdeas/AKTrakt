//
//  TraktEpisode.swift
//  Arsonik
//
//  Created by Florian Morello on 15/04/15.
//  Copyright (c) 2015 Florian Morello. All rights reserved.
//

import Foundation

public class TraktEpisode: TraktObject, Descriptable, Watchable {
    public let number: UInt
    public var seasonNumber: UInt?
    public var loaded: Bool? = false
    public var firstAired: NSDate?

    /// Descriptable conformance
    public var title: String?
    public var overview: String?

    /// Watchable conformance
    public var watched: Bool = false
    public var watchlist: Bool = false
    public var lastWatchedAt: NSDate?
    public var plays: UInt?

    required public init?(data: JSONHash!) {
        guard let en = data?["number"] as? UInt else {
            return nil
        }

        number = en
        seasonNumber = data?["season"] as? UInt
        super.init(data: data)
    }

    override public func digest(data: JSONHash!) {
        super.digest(data)

        if let fa = data["first_aired"] as? String, date = Trakt.datetimeFormatter.dateFromString(fa) {
            firstAired = date
        }

        title = data?["title"] as? String ?? title
        overview = data?["overview"] as? String ?? overview
        watched = data?["completed"] as? Bool ?? watched
        plays = data?["plays"] as? UInt ?? plays
        if let fa = data["last_watched_at"] as? String, date = Trakt.datetimeFormatter.dateFromString(fa) {
            lastWatchedAt = date
        }
    }

    public override var description: String {
        return "TraktEpisode id\(id) \(seasonNumber):\(number)) completed \(watched)"
    }
}
