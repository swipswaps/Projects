//
//  ExperimentOptionsScreen.swift
//  TMR App
//
//  Created by Robert Zhang on 7/6/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

//to choose cueing options (w/ cueing, no cueing, control, etc...)

import Foundation
import SpriteKit

class TMRModelExpOptions:TMRModel{
    
    var treatment1 = SKLabelNode()
    var button1 = SKSpriteNode()
    
    var treatment2 = SKLabelNode()
    var button2 = SKSpriteNode()
    
    var next = SKSpriteNode()
    
    var currentTreatment = 0 // default option (none selected) 1 - sleep, 2 - no sleep
    
    var is1Selected = false
    var is2Selected = false
    
    override func begin(screen : TMRScreen, context : TMRContext,view:SKView) {
        super.begin(screen: screen, context: context)
        screen.clearScreen()
        
        let title = SKLabelNode(position: CGPoint(x:screen.frame.width/2,y:screen.frame.height-30), zPosition: 1, text: "Select Treatment", fontColor: UIColor(red:97/255,green:175/255,blue:175/255,alpha:1), fontName: "Arial Bold", fontSize: 30, verticalAlignmentMode: .top, horizontalAlignmentMode: .center)
        screen.addChild(title)
        
        let bg = SKSpriteNode(color: UIColor(red:40/255,green:44/255,blue:52/255,alpha:1), width: screen.frame.width, height: screen.frame.height, anchorPoint: CGPoint(x:0,y:0), position: CGPoint(x:0,y:0), zPosition: 0, alpha: 1)
        screen.addChild(bg)
        
        treatment1 = SKLabelNode(position: CGPoint(x:screen.frame.width/2,y:screen.frame.height*2/3), zPosition: 2, text: "Cueing During Sleep", fontColor: .lightText, fontName: "Arial Bold", fontSize: 30, verticalAlignmentMode: .center, horizontalAlignmentMode: .center)
        treatment1.name = "treatment"
        screen.addChild(treatment1)
        
        button1 = SKSpriteNode(color: .darkGray, width: treatment1.frame.width+20, height: treatment1.frame.height+20, anchorPoint: CGPoint(x:0.5,y:0.5), position: treatment1.position, zPosition: 1, alpha: 1)
        button1.name = "button"
        screen.addChild(button1)
        
        treatment2 = SKLabelNode(position: CGPoint(x:screen.frame.width/2,y:button1.position.y-button1.size.height/2-40), zPosition: 2, text: "Cueing Without Sleep", fontColor: .lightText, fontName: "Arial Bold", fontSize: 30, verticalAlignmentMode: .center, horizontalAlignmentMode: .center)
        treatment2.name = "treatment"
        screen.addChild(treatment2)
        
        button2 = SKSpriteNode(color: .darkGray, width: treatment1.frame.width+20, height: treatment2.frame.height+20, anchorPoint: CGPoint(x:0.5,y:0.5), position: treatment2.position, zPosition: 1, alpha: 1)
        button2.name = "button"
        screen.addChild(button2)
        
        next = SKSpriteNode(imageName: "NextIcon", ySize: screen.frame.height/7, anchorPoint: CGPoint(x:0.5,y:0.5), position: CGPoint(x:screen.frame.width/2,y:screen.frame.height*0.3), zPosition: 2, alpha: 1)
        screen.addChild(next)
        
    }
    
    override func timerTick(screen : TMRScreen, context : TMRContext) {
        
    }
    
    
    override func touch(screen : TMRScreen, context:TMRContext, position: CGPoint) {
        if button1.contains(position){
            if is1Selected{
                treatment1.fontColor = .lightText
                button1.color = .darkGray
                currentTreatment = 0
                is1Selected = false
            }else{
                for child in screen.children{
                    if child.name == "button"{
                        let c = child as! SKSpriteNode
                        c.color = .darkGray
                    }
                    if child.name == "treatment"{
                        let c = child as! SKLabelNode
                        c.fontColor = .lightText
                    }
                }
                is2Selected = false
                treatment1.fontColor = .black
                button1.color = .white
                currentTreatment = 1
                is1Selected = true
            }
            
        }
        if button2.contains(position){
            if is2Selected{
                treatment2.fontColor = .lightText
                button2.color = .darkGray
                currentTreatment = 0
                is2Selected = false
            }else{
                for child in screen.children{
                    if child.name == "button"{
                        let c = child as! SKSpriteNode
                        c.color = .darkGray
                    }
                    if child.name == "treatment"{
                        let c = child as! SKLabelNode
                        c.fontColor = .lightText
                    }
                }
                is1Selected = false
                treatment2.fontColor = .black
                button2.color = .white
                currentTreatment = 2
                is2Selected = true
            }
            
        }
        
        if next.contains(position){
            if currentTreatment != 0{
                if currentTreatment == 1{
                    context.project.setSubjectNapped(num: 1)
                }else{
                    context.project.setSubjectNapped(num: 0)
                }
                let setting = context.project.getGuiSetting()
                setting.setTreatmentNum(num: currentTreatment)
                context.project.setGuiSetting(guiSetting: setting)
                context.nextModel = .CueingSetup
            }else{
//                let setting = context.project.getGuiSetting()
//                setting.setTreatmentNum(num: 1)
//                context.project.setGuiSetting(guiSetting: setting)
            }
            print(context.project.getGuiSetting().getTreatmentNum())
            
        }
    }
    
    override func end(screen : TMRScreen, context : TMRContext){
        
    }
}
