import Foundation
import AppKit

//: Find object type
// NS or UI prefix work for classForCoder()
NSObject.self // NSObject.Type
NSObject.classForCoder() // Mystry

NSColor.self
NSColor.classForCoder()

// Foundamental types
String.self
// String.classForCoder()   // this didn't work.
Int.self
// Int.classForCoder()      // this didn't work too.

