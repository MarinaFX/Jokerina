//
//  JokeWidgetBundle.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 25/08/21.
//

import SwiftUI
import WidgetKit

@main
struct JokeWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        RandomJokeWidget()
        CustomJokeWidget()
    }
}
