//
//  main.swift
//  ProcessTool
//
//  Created by Pedro José Pereira Vieito on 12/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import FoundationKit
import PwnedKit
import ArgumentParser

struct PwnedTool: ParsableCommand {
    static var configuration: CommandConfiguration {
        return CommandConfiguration(commandName: String(describing: Self.self))
    }
    
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Input passwords.")
    var input: Array<String>
    
    @Flag(name: .shortAndLong, help: "Verbose mode.")
    var verbose: Bool
    
    func validate() throws {
        guard !self.input.isEmpty else {
            throw ValidationError("No input items specified.")
        }
    }
    
    func run() throws {
        Logger.logMode = .commandLine
        Logger.logLevel = self.verbose ? .debug : .info
        
        for inputPassword in self.input {
            if self.input.count > 1 {
                Logger.log(important: inputPassword)
            }
            
            do {
                let occurences = try PwnedPasswordManager.check(password: inputPassword)
                Logger.log(info: "Occurrences: \(occurences)")
            }
            catch {
                Logger.log(warning: error)
            }
        }
    }
}

PwnedTool.main()
