//
//  main.swift
//  ProcessTool
//
//  Created by Pedro José Pereira Vieito on 12/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import CommandLineKit
import PwnedKit

let inputOption = MultiStringOption(shortFlag: "i", longFlag: "input", required: true, helpMessage: "Input passwords.")
let verboseOption = BoolOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Verbose mode.")
let helpOption = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

let cli = CommandLineKit.CommandLine()
cli.addOptions(inputOption, verboseOption, helpOption)

do {
    try cli.parse(strict: true)
}
catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if helpOption.value {
    cli.printUsage()
    exit(0)
}

Logger.logMode = .commandLine
Logger.logLevel = verboseOption.value ? .debug : .info

guard let inputPasswords = inputOption.value else {
    Logger.log(fatalError: "No input items specified.")
}

for inputPassword in inputPasswords {
    if inputPasswords.count > 1 {
        Logger.log(important: inputPassword)
    }
    
    do {
        let occurences = try PwnedPasswords.check(inputPassword)
        Logger.log(info: "Occurrences: \(occurences)")
    }
    catch {
        Logger.log(warning: error)
    }
}
