//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Domenica Torres on 3/1/22.
//

import Foundation
//create a struct and an enum to represent the data:
struct Question{
    var text: String
    var type: ResponseType
    var answers: [Answer]
}
enum ResponseType{
    case single, multiple, ranged
}

struct Answer{
    var text: String
    var type: AnimalType
}
enum AnimalType: Character { //the reason that I chose character is because the user can select an emoji
    case dog = "🐶", cat = "🐱", monkey = "🐵", rabbit = "🐰"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You sorround yourself with people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered. You enjoy doing things on your own terms."
        case .monkey:
            return "You are very funny and positive. You are full of energy and your enthusiasm makes people feel better."
        case .rabbit:
            return "You love cuddles and everything that is soft. You are very healthy and very mindful."
        }
    }
}

