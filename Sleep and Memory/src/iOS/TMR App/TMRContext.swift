//
//  TMRContext.swift
//  TMR App
//
//  Created by Robert Zhang on 6/17/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation

enum ModelType {
    case None,
        Home,Settings,Training,Testing,PreNapTest,PreNapResult,
        Queuing,Retest,Result,End
}

// current running context
class TMRContext {
    var userAccount : UserAccount
    var project     : TMRProject
    
    //resourceIndexList either get from project like training, or the shuffled one for testing
    var resourceIndexList = [Int]()
    
    var currentModel : ModelType = .Home
    private var _nextModelType : ModelType = .Home
    
    var nextModel    : ModelType {
        get {
            return _nextModelType
        }
        set(newType){
            _nextModelType = newType
            modelUpdateFlag = true
        }
    }
    
    var modelUpdateFlag : Bool = false
    var model       : TMRModel
    var repeatCnt : Int = 0
    
    var curIdx = 0;

    init() {
        userAccount = UserAccountFactory.createUserAccount(userName: "Robert", password: "")
        project = TMRProjectFactory.getTMRProject(userAccount : userAccount)
        
        model  = TMRModelHome() as TMRModel // initial model
    }
    
    func modelUpdate(screen : TMRScreen){
        if !modelUpdateFlag {
            return
        }
        modelUpdateFlag = false
        
        // stop current
        self.model.end(screen: screen, context: self)
        // get next
        switch(self.nextModel){
        case .Home:
            self.model = TMRModelHome()
        case .Settings:
            self.model = TMRModelSettings()
        case .Training:
            self.model = TMRModelTraining()
        case .Testing, .PreNapTest, .Retest:
            self.model = TMRModelTesting()
        case .Queuing:
            self.model = TMRModelQueuing()
        case .PreNapResult:
            self.model = TMRModelStatBefore()
        case .Result:
            self.model = TMRModelResult()
        case .End:
            self.model = TMRModelEnd()
        default:
            assertionFailure("no model type defined")
        }
        self.currentModel = self.nextModel
        self.model.begin(screen: screen, context: self)
        // start next
    }

    
    func getResourceIndexList() -> [Int] {
        return resourceIndexList
    }
    
    func setResourceIndexList(resourceIndexList : [Int] ) {
        self.resourceIndexList = resourceIndexList
    }
    
}