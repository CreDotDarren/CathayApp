//
//  Globals.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/6/1.
//

import Foundation

public class Globals {
        
    static var CathayServerEndPoint: String = ""
    

    private init() { }
    
    static func Initialize()
    {
//        正式
        Globals.CathayServerEndPoint = "https://willywu0201.github.io"

    }
    static func getCathayServerEndPoint(queryPath: String) -> String {
        return "\(Globals.CathayServerEndPoint)\(queryPath)"
    }
}
