//
//  PinView.swift
//  Mastermind
//
//  Created by Holger Becker on 28.08.23.
//

import SwiftUI

struct CodePin: View {
    @EnvironmentObject var vm: MastermindViewModel
    
    @Binding var color: MastermindModel.PinColor
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                let r = geometry.size.width / 10
                let x = geometry.size.width / 10
                let y = geometry.size.height / 5
                switch color {
                case .blue:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.113299571, green: 0.2254185975, blue: 0.389888525, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .green:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0, green: 0.7074271347, blue: 0.2091305272, alpha: 1)), Color(#colorLiteral(red: 0.1696736813, green: 0.4432701468, blue: 0.2040996552, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .red:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5440903306, green: 0.2053359747, blue: 0.1289318502, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .yellow:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5882523656, green: 0.5808454156, blue: 0.2724194527, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .purple:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09632822126, green: 0.1214332953, blue: 0.3032752573, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .orange:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.5779412389, green: 0.3737699389, blue: 0.1621670425, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .brown:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)), Color(#colorLiteral(red: 0.2571106255, green: 0.1868104339, blue: 0.08885326236, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .pink:
                    Circle().fill(RadialGradient(colors: [.white, Color(#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.4321783781, green: 0.3114494383, blue: 0.4337245226, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        .shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                    //.shadow(color: Color.white.opacity(0.7), radius: x, x: -x, y: -y)
                case .empty:
                    Circle().stroke(RadialGradient(colors: [.white, Color(#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)), Color(#colorLiteral(red: 0.113299571, green: 0.2254185975, blue: 0.389888525, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5), lineWidth: 5)
                        .background {
                            Circle().fill(RadialGradient(colors: [.black, Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))], center: .topLeading, startRadius: -geometry.size.height * 0.5, endRadius: geometry.size.height * 2.5))
                        }
                        .shadow(color: Color.black.opacity(0.1), radius: r, x: x, y: y)
                        //.shadow(color: Color.black.opacity(0.5), radius: r, x: x, y: y)
                }
            }
        }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        CodePin(color: .constant(.empty))
            .frame(width: 70, height: 70)
            .environmentObject(MastermindViewModel())
    }
}
