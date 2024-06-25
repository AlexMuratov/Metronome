//
//  MainScreenView.swift
//  Metronome
//
//  Created by Alexander Muratov on 25.06.24.
//

import SwiftUI
import AudioToolbox

struct MainScreenView: View {
    @StateObject private var viewModel = MainScreenViewModel()
    
    var body: some View {
        VStack {
            Text("BPM: \(Int(viewModel.bpm))")
                .font(.largeTitle)
                .padding()
            Slider(value: $viewModel.bpm, in: 40...240, step: 1)
                .padding()
            Button(action: {
                if viewModel.isPlaying {
                    viewModel.stopMetronome()
                } else {
                    viewModel.startMetronome()
                }
            }) {
                Text(viewModel.isPlaying ? "Stop" : "Start")
                    .font(.title)
                    .padding()
                    .background(viewModel.isPlaying ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
