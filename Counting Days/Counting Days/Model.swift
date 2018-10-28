//
//  Model.swift
//  Counting Days
//
//  Created by Zhong, Zhetao on 10/27/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import Foundation

struct Tile : Codable {
    var index = 0
    var faceUp = false
    var emoji = ""
}

class Model : Codable {
    
    private let emojis = "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥥🥝🍅🍆🥑🥦🥒🌶🌽🥕🥔"
    
    var tilesArray = [Tile]()
    
    func initGame(with numberOfTiles: Int) {
        
        var emojisArray = [String]()
        
        for i in 0..<numberOfTiles {
            let startSlice = emojis.index(emojis.startIndex, offsetBy: i)
            let endSlice = emojis.index(startSlice, offsetBy: 1)
            let slice = String(emojis[startSlice..<endSlice])
            
            // do it twice
            emojisArray.append(slice)
            emojisArray.append(slice)
        }
        
        // comment out for debugging
        //        randomEmojisArray.shuffle()
        
        for i in 0..<numberOfTiles {
            let tile = Tile(index: i, faceUp: false, emoji: emojisArray[i])
            tilesArray.append(tile)
        }
    }
    
    
    func isFaceUp(_ index: Int) -> Bool {
        return tilesArray[index].faceUp
    }
    
    func emoji(for index: Int) -> String? {
        guard index < tilesArray.count else { return nil }
        
        let tile = tilesArray[index]
        return tile.faceUp ? tile.emoji : nil
    }

    
}
