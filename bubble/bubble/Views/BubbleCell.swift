//
//  BubbleCell.swift
//  bubble
//
//  Created by Dhruv Upadhyay on 3/11/18.
//  Copyright © 2018 CS 408. All rights reserved.
//

import UIKit

class BubbleCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet var bubbleText: UITextView!
    var bubble: Bubble!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bubbleText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(bubble: Bubble) {
        self.bubble = bubble
        bubbleText.text = bubble.text
    }
    
    func saveBubbleText() {
        let bubbleData = ["text": bubbleText.text]
        DataService.instance.updateBubble(bubbleID: bubble.uid, bubbleData: bubbleData)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        let count = bubbleText.text.count
        if range.length + range.location > count {
            return false
        }
        
        let newLength = count + text.count - range.length
        return newLength <= 140
    }
}
