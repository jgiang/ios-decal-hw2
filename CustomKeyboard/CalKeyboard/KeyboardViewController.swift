//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {


    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var returnKeyboardButton: UIButton!
    @IBOutlet var deleteKeyboardButton: UIButton!
    @IBOutlet var hashtagKeyboardButton: UIButton!
    @IBOutlet var noseGoesKeyboardButton: UIButton!
    @IBOutlet var shrugKeyboardButton: UIButton!
    @IBOutlet var clearKeyboardButton: UIButton!
    @IBOutlet var leftKeyboardButton: UIButton!
    @IBOutlet var rightKeyboardButton: UIButton!
    
    var keyboardView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    
    func returnClick() {
        textDocumentProxy.insertText("\n")
    }
    
    func deleteClick() {
        textDocumentProxy.deleteBackward()
    }
    
    func hashtagClick() {
        // get all the benefits of autocorrect AND the easy of creating long, sarcastic hashtags
        if let offset = textDocumentProxy.documentContextAfterInput {
            textDocumentProxy.adjustTextPositionByCharacterOffset(offset.characters.count)

        }
        
        let before = textDocumentProxy.documentContextBeforeInput!
        
        for (var i = before.characters.count; i > 0; i--) {
            textDocumentProxy.deleteBackward()
        }
        
        var sections = before.componentsSeparatedByString("#")
        for (var i = 0; i < sections.count; i++) {
            if i == 0 {
                textDocumentProxy.insertText(sections[i])
            } else {
                textDocumentProxy.insertText(" #" + sections[i].stringByReplacingOccurrencesOfString(" ", withString: ""))
            }
        }
    }
    
    func noseGoesClick() {
        textDocumentProxy.insertText("👉🏼👃🏼👈🏼\n     👆🏼")
    }
    
    func shrugClick() {
        textDocumentProxy.insertText("¯\\_(ツ)_/¯")
    }
    
    func clearClick() {
        // clear all text
        if let offset = textDocumentProxy.documentContextAfterInput {
            textDocumentProxy.adjustTextPositionByCharacterOffset(offset.characters.count)
            
        }
        
        let before = textDocumentProxy.documentContextBeforeInput!
        
        for (var i = before.characters.count; i > 0; i--) {
            textDocumentProxy.deleteBackward()
        }
    }
    
    func leftClick() {
        textDocumentProxy.adjustTextPositionByCharacterOffset(-1)
    }
    
    func rightClick() {
        textDocumentProxy.adjustTextPositionByCharacterOffset(1)
    }
    
    func loadCustomButtons() {
        returnKeyboardButton.addTarget(self, action: "returnClick", forControlEvents: .TouchUpInside)
        deleteKeyboardButton.addTarget(self, action: "deleteClick", forControlEvents: .TouchUpInside)
        hashtagKeyboardButton.addTarget(self, action: "hashtagClick", forControlEvents: .TouchUpInside)
        noseGoesKeyboardButton.addTarget(self, action: "noseGoesClick", forControlEvents: .TouchUpInside)
        shrugKeyboardButton.addTarget(self, action: "shrugClick", forControlEvents: .TouchUpInside)
        clearKeyboardButton.addTarget(self, action: "clearClick", forControlEvents: .TouchUpInside)
        leftKeyboardButton.addTarget(self, action: "leftClick", forControlEvents: .TouchUpInside)
        rightKeyboardButton.addTarget(self, action: "rightClick", forControlEvents: .TouchUpInside)
    }
    
    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside) // advanceToNextInputMode is already defined in template
        loadCustomButtons()
    }


}
