//
//  TodoRepositoryFactorySpec.swift
//  SwiftTODOsTests
//
//  Created by Vitor Navarro on 2017-12-28.
//  Copyright © 2017 Vitor Navarro. All rights reserved.
//

import Quick
import Nimble
import SwiftTODOs

class TodoRepositoryFactorySpec: QuickSpec {
    
    override func spec() {
        describe("TodoRepositoryFactorySpec") {
            
            context("Local storage creation") {
                it("create new instance") {
                    expect(TodoRepositoryFactory.createLocalRepository()).toNot(beNil())
                }
            }
        }
    }
    
}
