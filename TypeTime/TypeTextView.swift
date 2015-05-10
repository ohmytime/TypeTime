//
//  TypeTextView.swift
//  TypeTime
//
//  Created by Rui-Wei Zhao on 5/6/15.
//  Copyright (c) 2015 Rui-Wei Zhao. All rights reserved.
//

import Cocoa

protocol TypeTextViewDelegate: NSTextViewDelegate {}

class TypeTextView: NSTextView, TypeTextViewDelegate {

    let defaultFont = NSFont(name: "Menlo", size: 24.0)
    let activeBackgroundColor = NSColor.textBackgroundColor()
    let inactiveBackgroundColor = NSColor.windowBackgroundColor()

    let helpMessage = "开始跟打请按：Command + L"

    func clearString() {
        textStorage?.mutableString.setString("")
        setDefaultFont()
    }

    func setupInitLookup() {
        inactivate()
        textStorage?.mutableString.setString(helpMessage)
        setDefaultFont()
    }

    func activate() {
        backgroundColor = activeBackgroundColor
        editable = true
        window?.makeFirstResponder(self)
    }

    func inactivate() {
        backgroundColor = inactiveBackgroundColor
        editable = false
    }

    func setDefaultFont() {
        font = defaultFont
    }

    override var readablePasteboardTypes: [AnyObject] {
        get {
            return [AnyObject]()
        }
    }

    override func keyDown(theEvent: NSEvent) {
        if editable == true {
            let notificationCenter = NSNotificationCenter.defaultCenter()
            let userInfo = ["event": theEvent]
            notificationCenter.postNotificationName("KeyDownInTypeTextViewNotification", object: self, userInfo: userInfo)
            switch theEvent.keyCode {
            case 0x7B, 0x7C, 0x7D, 0x7E:  // arrow keys
                break
            default:
                super.keyDown(theEvent)
            }
        } else {
            super.keyDown(theEvent)
        }
    }

    override func mouseDown(theEvent: NSEvent) {
        if editable == false {
            super.mouseDown(theEvent)
        }
    }

    override func rightMouseDown(theEvent: NSEvent) {
        if editable == false {
            super.rightMouseDown(theEvent)
        }
    }

}