//
//  main.swift
//  BerlinClock
//
//  Created by kickdown on 28.01.2025.
//

import Foundation

enum Status : String {
    case off = "O"
    case red = "R"
    case yellow = "Y"
}

struct BerlinClock {
    
    func BerlinTime (from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
               
        guard let hour = components.hour, let minute = components.minute, let second = components.second else {
                   return "Invalid Date" // Handle potential errors
        }

        
        let secondlamp = SecondsLamp(seconds: second)
        let fivehourlamp = FiveHourLamp(hours: hour)
        let hourlamp = HourLamp(hours: hour)
        let fiveminutelamp = FiveMinuteLamp(minutes: minute)
        let minutelamp = MinuteLapm(minutes: minute)
        
        return "\(secondlamp)\(fivehourlamp)\(hourlamp)\(fiveminutelamp)\(minutelamp)"
    }
    
    private func SecondsLamp (seconds: Int) -> String{
        if(seconds % 2 == 0){
            return Status.yellow.rawValue
        }
        else{
            return Status.off.rawValue
        }
    }
    
    private func getLamps (maxLamps: Int, count: Int, lampStatus: Status) -> String{
        return String(repeating: lampStatus.rawValue, count: count) + String(repeating: Status.off.rawValue, count: maxLamps - count)
    }
    
    
    
    private func FiveHourLamp (hours: Int) -> String{
        return getLamps(maxLamps: 4, count: hours / 5, lampStatus: .red)
    }
    
    private func HourLamp (hours: Int) -> String {
        return getLamps(maxLamps: 4, count: hours % 5, lampStatus: .red)
    }
    
    private func FiveMinuteLamp (minutes: Int) -> String{
        let fiveMinutesLampsCount = minutes / 5
        var lampsStatus = ""
        for i in 1...11{
            if i <= fiveMinutesLampsCount{
                if i % 3 == 0{
                    lampsStatus += Status.red.rawValue
                }
                else{
                    lampsStatus += Status.yellow.rawValue
                }
            }
            else{
                lampsStatus += Status.off.rawValue
            }
        }
        return lampsStatus
    }
    
    private func MinuteLapm (minutes: Int) -> String{
        return getLamps(maxLamps: 4, count: minutes % 5, lampStatus: .yellow)
    }
    
}

let clock = BerlinClock()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "HH:mm:ss"

let testDate = dateFormatter.date(from: "16:50:06")!

let berlinTime = clock.BerlinTime(from: testDate)
print(berlinTime)



