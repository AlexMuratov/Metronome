//
//  MainScreenViewModel.swift
//  Metronome
//
//  Created by Alexander Muratov on 25.06.24.
//

import Foundation
import AudioToolbox
import Combine

final class MainScreenViewModel: ObservableObject {
    @Published var bpm: Double = 120.0 {
        didSet {
            if isPlaying {
                restartMetronome()
            }
        }
    }
    @Published var isPlaying = false
    
    private var timer: Timer?
    private var soundID: SystemSoundID = 1104
    private var cancellables = Set<AnyCancellable>()

    init() {
        $bpm
            .sink { [weak self] _ in
                self?.updateTimer()
            }
            .store(in: &cancellables)
    }
    
    func startMetronome() {
        let interval = 60.0 / bpm
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.playClickSound()
        }
        isPlaying = true
    }

    func stopMetronome() {
        timer?.invalidate()
        timer = nil
        isPlaying = false
    }
    
    private func restartMetronome() {
        updateTimer()
    }
    
    private func updateTimer() {
        timer?.invalidate()
        if isPlaying {
            startMetronome()
        }
    }

    private func playClickSound() {
        AudioServicesPlaySystemSound(soundID)
    }
}
