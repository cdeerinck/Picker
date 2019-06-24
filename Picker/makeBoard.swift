//
//  drawBoard.swift
//  Picker
//
//  Created by Chuck Deerinck on 6/21/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func makeBoard() {
    for x in 0...49 {
        for y in 0...49 {
            var kind:tiles
            if y == 0 || y==49 {
                kind = .red
            } else if y == 1 || y==48 {
                kind = .green
            } else {
                let r = Int.random(in: 0...100)
                switch r {
                    case 0:
                        kind = .green
                    case 1...3:
                        kind = .red
                    case 21:
                        kind = .black
                    case 30...34:
                        kind = .none
                    default:
                        kind = .white
                    }
            }
            placeTile(x,y, kind)
        }
    }
}
