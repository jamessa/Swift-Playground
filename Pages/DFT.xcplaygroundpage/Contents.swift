//: [Previous](@previous)
//  https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/USingDFTFunctions/USingDFTFunctions.html#//apple_ref/doc/uid/TP40005147-CH4-SW1

import Foundation
import Accelerate
import XCPlayground

// Playground Helper
func plot<T>(values: [T], title: String) {
    for value in values {
        XCPlaygroundPage.currentPage.captureValue(value, withIdentifier: title)
    }
}

// Time Domain to Freqency Domain
let real:[Float] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]

plot(real, title: "Time Domain")
let imaginary = [Float](count:real.count, repeatedValue: 0.0)

var real_output = [Float](count:real.count, repeatedValue: 0.0)
var imaginary_output = [Float](count:real.count, repeatedValue: 0.0)

let length = vDSP_Length(real.count)


let weights = vDSP_DFT_zop_CreateSetup(nil, length, vDSP_DFT_Direction.FORWARD)

vDSP_DFT_Execute(weights, real, imaginary, &real_output, &imaginary_output)

for (i, r) in real_output.enumerate() {
    print("\(r) \(imaginary_output[i])i")
    XCPlaygroundPage.currentPage.captureValue(r*r+imaginary_output[i]*imaginary_output[i], withIdentifier: "Freqency Domain")
}