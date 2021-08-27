//
//  JokeWidgetView.swift
//  Jokerina
//
//  Created by Marina De Pazzi on 24/08/21.
//

import SwiftUI
import WidgetKit

protocol JokeWidgetDelegate: AnyObject {
    func onOpenUrl(with url: URL)
}

struct JokeWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    let joke: Joke
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallJokeWidgetView(joke: joke)
        case .systemMedium:
            MediumJokeWidgetView(joke: joke)
        case .systemLarge:
            LargeJokeWidgetView(joke: joke)
        @unknown default:
            EmptyView()
        }
    }
    
}

struct JokeWidgetPlaceholderView: View {
    var body: some View {
        Color(UIColor(named: "POLI") ?? .systemIndigo)
    }
}

struct SmallJokeWidgetView: View {
    
    let joke: Joke
    static weak var delegate: JokeWidgetDelegate?
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "POLI") ?? .systemIndigo)
            
            VStack {
                Text(joke.question)
                    .font(.system(size: 15))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(.white)

                Text(joke.answer)
                    .font(.system(size: 10))
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 10)
                    .foregroundColor(.white)
            }
        }
    }
}

//extension View {
//    func widgetURL(with url: URL) {
//        SmallJokeWidgetView.delegate?.onOpenUrl(with: url)
//    }
//}

struct MediumJokeWidgetView: View {
    
    let joke: Joke
    
    var body: some View {
        ZStack{
            Color(UIColor(named: "POLI") ?? .systemIndigo)
            
            HStack {
                Text("😂")
                    .font(.system(size: 56))
                    .padding(.leading, 10)
                
                VStack{
                    Text(joke.question)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding([.leading, .trailing], 10)
                        .foregroundColor(.white)

                    Text(joke.answer)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding([.top, .bottom], 10)
                        .padding([.leading, .trailing], 10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct LargeJokeWidgetView: View {
    
    let joke: Joke
    
    var body: some View {
        ZStack{
            Color(UIColor(named: "POLI") ?? .systemIndigo)
            
                
            VStack {
                Text("😂😂😂")
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .font(.system(size: 56))
                
                Text(joke.question)
                    .font(.system(size: 20))
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.white)
                
                Text(joke.answer)
                    .font(.system(size: 15))
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 20)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.white)
            }
        }
    }
}

struct JokeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediumJokeWidgetView(joke: JokeProvider.random())
    }
}
