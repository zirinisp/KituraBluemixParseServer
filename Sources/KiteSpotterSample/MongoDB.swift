//
//  DatabaseConfiguration.swift
//  KiteSpotterSample
//
//  Created by Pantelis Zirinis on 22/01/2017.
//
//

import Foundation
import MongoKitten
import LoggerAPI

public class MongoDB {
    
    public var uri: String
    
    static let defaultUri = "mongodb://username:password@host:port"

    public init(uri: String = MongoDB.defaultUri) {
        self.uri = uri
    }
    
    static var shared = MongoDB()
    
    lazy var server: Server = {
        let server: Server!
        
        do {
            server = try Server(mongoURL: self.uri)
        } catch {
            // Unable to connect
            Log.error("MongoDB is not available on the given host and port")
            exit(1)
        }
        return server
    }()
    
    lazy var database: Database = {
        let db = self.server["kitespotterdev"] // Replace with your database name
        return db
    }()
    
    lazy var kiteSpotCollection: MongoKitten.Collection = {
        self.database["KiteSpot"] // Replace with your collection name
    }()
    
    func findOneKiteSpot() -> Document? {
        do {
            let doc = try self.kiteSpotCollection.findOne()
            return doc
        } catch {
            Log.error("Could not find spot")
            return nil
        }
    }
}
