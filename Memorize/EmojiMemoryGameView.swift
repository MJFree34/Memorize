//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matt Free on 8/10/21.
//

import SwiftUI

//struct EmojiMemoryGameView: View {
//    @ObservedObject var game: EmojiMemoryGame
//    
//    @Namespace private var dealingNamespace
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            VStack {
//                gameBody
//                
//                HStack {
//                    restart
//                    Spacer()
//                    shuffle
//                }
//                .padding(.horizontal)
//            }
//            deckBody
//        }
//        .padding()
//    }
//    
//    @State private var dealt = Set<Int>()
//    
//    var gameBody: some View {
//        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
//            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
//                Color.clear
//            } else {
//                CardView(card: card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                    .padding(4)
//                    .transition(.asymmetric(insertion: .identity, removal: .scale).animation(.easeInOut))
//                    .zIndex(zIndex(of: card))
//                    .onTapGesture {
//                        withAnimation {
//                            game.choose(card)
//                        }
//                    }
//            }
//        }
//        .foregroundColor(CardConstants.color)
//    }
//    
//    var deckBody: some View {
//        ZStack {
//            ForEach(game.cards.filter(isUndealt)) { card in
//                CardView(card: card)
//                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
//                    .transition(.asymmetric(insertion: .opacity, removal: .identity).animation(.easeInOut))
//            }
//        }
//        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
//        .foregroundColor(CardConstants.color)
//        .onTapGesture {
//            for card in game.cards {
//                withAnimation(dealAnimation(for: card)) {
//                    deal(card)
//                }
//            }
//        }
//    }
//    
//    var shuffle: some View {
//        Button("Shuffle") {
//            withAnimation {
//                game.shuffle()
//            }
//        }
//    }
//    
//    var restart: some View {
//        Button("Restart") {
//            withAnimation {
//                dealt = []
//                game.restart()
//            }
//        }
//    }
//    
//    private func deal(_ card: EmojiMemoryGame.Card) {
//        dealt.insert(card.id)
//    }
//    
//    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
//        !dealt.contains(card.id)
//    }
//    
//    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
//        var delay = 0.0
//        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
//            delay = Double(index) * CardConstants.totalDealDuration / Double(game.cards.count)
//        }
//        return .easeInOut(duration: CardConstants.dealDuration).delay(delay)
//    }
//    
//    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
//        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
//    }
//    
//    private struct CardConstants {
//        static let color: Color = .red
//        static let aspectRatio = 2.0 / 3.0
//        static let dealDuration = 0.5
//        static let totalDealDuration = 2.0
//        static let undealtHeight = 90.0
//        static let undealtWidth = undealtHeight * aspectRatio
//    }
//}
//
//struct CardView: View {
//    let card: EmojiMemoryGame.Card
//
//    @State private var animatedBonusRemaining = 0.0
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Group {
//                    if card.isConsumingBonusTime {
//                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - animatedBonusRemaining) * 360 - 90))
//                            .onAppear {
//                                animatedBonusRemaining = card.bonusRemaining
//
//                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
//                                    animatedBonusRemaining = 0
//                                }
//                            }
//                    } else {
//                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - card.bonusRemaining) * 360 - 90))
//                    }
//                }
//                .padding(5)
//                .opacity(DrawingConstants.circleOpacity)
//
//                Text(card.content)
//                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
//                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
//                    .font(Font.system(size: DrawingConstants.fontSize))
//                    .scaleEffect(scale(thatFits: geometry.size))
//            }
//            .cardify(isFaceUp: card.isFaceUp)
//        }
//    }
//
//    private func scale(thatFits size: CGSize) -> CGFloat {
//        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
//    }
//
//    private struct DrawingConstants {
//        static let fontScale = 0.7
//        static let fontSize = 32.0
//        static let circleOpacity = 0.5
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        return EmojiMemoryGameView(game: game)
//    }
//}

// MARK: - Assignment VI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    @State private var dealt = Set<Int>()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack(alignment: .center) {
                    Text(game.themeName)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Text("Score: \(game.score)")
                }
                
                gameBody

                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(.asymmetric(insertion: .identity, removal: .scale).animation(.easeInOut))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundStyle(game.fillColor)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity).animation(.easeInOut))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundStyle(game.fillColor)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }

    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }

    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.newGame()
            }
        }
    }
    
//    var body: some View {
//        VStack {
//            HStack(alignment: .center) {
//                Text(viewModel.themeName)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//
//                Spacer()
//
//                Text("Score: \(viewModel.score)")
//            }
//
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
//                    ForEach(viewModel.cards) { card in
//                        CardView(card: card)
//                            .aspectRatio(2/3, contentMode: .fit)
//                            .onTapGesture {
//                                viewModel.choose(card)
//                            }
//                    }
//                }
//            }
//            .foregroundStyle(viewModel.fillColor)
//            .overlay(
//                VStack {
//                    Spacer()
//
//                    Button("New Game") {
//                        viewModel.newGame()
//                    }
//                    .font(.title)
//                    .padding()
//                    .buttonStyle(.borderedProminent)
//                }
//            )
//
//        }
//        .padding(.horizontal)
//    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }

    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * CardConstants.totalDealDuration / Double(game.cards.count)
        }
        return .easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let aspectRatio = 2.0 / 3.0
        static let dealDuration = 0.5
        static let totalDealDuration = 2.0
        static let undealtHeight = 90.0
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(5)
                .opacity(DrawingConstants.circleOpacity)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale = 0.7
        static let fontSize = 32.0
        static let circleOpacity = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: Theme(variation: .vehicles))

        EmojiMemoryGameView(game: game)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}

// MARK: - Assignment II

//struct EmojiMemoryGameView: View {
//    @ObservedObject var viewModel: EmojiMemoryGame
//
//    var body: some View {
//        VStack {
//            HStack(alignment: .center) {
//                Text(viewModel.themeName)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//
//                Spacer()
//
//                Text("Score: \(viewModel.score)")
//            }
//
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
//                    ForEach(viewModel.cards) { card in
//                        CardView(card: card)
//                            .aspectRatio(2/3, contentMode: .fit)
//                            .onTapGesture {
//                                viewModel.choose(card)
//                            }
//                    }
//                }
//            }
//            .foregroundStyle(viewModel.fillColor)
//            .overlay(
//                VStack {
//                    Spacer()
//
//                    Button("New Game") {
//                        viewModel.newGame()
//                    }
//                    .font(.title)
//                    .padding()
//                    .buttonStyle(.borderedProminent)
//                }
//            )
//
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct CardView: View {
//    let card: MemoryGame<String>.Card
//
//    var body: some View {
//        let shape = RoundedRectangle(cornerRadius: 20)
//
//        ZStack {
//            if card.isFaceUp {
//                shape
//                    .fill()
//                    .foregroundColor(.white)
//
//                shape
//                    .strokeBorder(lineWidth: 3)
//
//                Text(card.content)
//                    .font(.largeTitle)
//            } else if card.isMatched {
//                shape.opacity(0)
//            } else {
//                shape
//                    .fill()
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame(theme: Theme(variation: .vehicles))
//
//        ContentView(viewModel: game)
//        ContentView(viewModel: game)
//            .preferredColorScheme(.dark)
//    }
//}

// MARK: - Assignment I

//enum Theme: String, CaseIterable {
//    case vehicles = "Vehicles"
//    case countries = "Countries"
//    case devices = "Devices"
//    case sports = "Sports"
//
//    var imageName: String {
//        switch self {
//        case .vehicles:
//            return "car"
//        case .countries:
//            return "flag"
//        case .devices:
//            return "iphone"
//        case .sports:
//            return "sportscourt"
//        }
//    }
//}
//
//struct ContentView: View {
//    @State private var emojis: [String] = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"].shuffled()
//    @State private var emojiCount = Int.random(in: 4..<20)
//    @State private var theme: Theme = .vehicles {
//        didSet {
//            switch theme {
//            case .vehicles:
//                emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻" , "🚝"].shuffled()
//            case .countries:
//                emojis = ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺"].shuffled()
//            case .devices:
//                emojis = ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "☎️", "📺", "📽", "📸"].shuffled()
//            case .sports:
//                emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍"].shuffled()
//            }
//
//            emojiCount = Int.random(in: 4..<emojis.count)
//        }
//    }
//
//    var body: some View {
//        VStack {
//            Text("Memorize!")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumCardWidth()))]) {
//                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
//                        CardView(content: emoji)
//                            .aspectRatio(2/3, contentMode: .fit)
//                    }
//                }
//            }
//            .foregroundColor(.red)
//
//            Spacer()
//
//            HStack(alignment: .bottom) {
//                ForEach(Theme.allCases, id: \.rawValue) { theme in
//                    ThemeButton(theme: theme) {
//                        self.theme = theme
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//    }
//
//    private func minimumCardWidth() -> CGFloat {
//        switch emojiCount {
//        case 4:
//            return 150
//        case 5...9:
//            return 110
//        case 10...16:
//            return 80
//        default:
//            return 65
//        }
//    }
//}
//
//struct ThemeButton: View {
//    let theme: Theme
//    let action: () -> Void
//
//    var body: some View {
//        Button {
//            action()
//        } label: {
//            VStack {
//                Image(systemName: theme.imageName)
//                    .font(.largeTitle)
//
//                Text(theme.rawValue)
//            }
//        }
//    }
//}
//
//struct CardView: View {
//    var content: String
//
//    @State var isFaceUp = true
//
//    var body: some View {
//        let shape = RoundedRectangle(cornerRadius: 20)
//
//        ZStack {
//            if isFaceUp {
//                shape
//                    .fill()
//                    .foregroundColor(.white)
//
//                shape
//                    .strokeBorder(lineWidth: 3)
//
//                Text(content)
//                    .font(.largeTitle)
//            } else {
//                shape
//                    .fill()
//            }
//        }
//        .onTapGesture {
//            isFaceUp.toggle()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//        ContentView()
//            .preferredColorScheme(.dark)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
