import AudioToolbox
import Darwin
import Swift
import XCPlayground

let a = [#FileReference(fileReferenceLiteral: "Sine_wave_440.wav")#]
var audioFileRef: ExtAudioFileRef = nil

let status = ExtAudioFileOpenURL(a, &audioFileRef)

var ioPropertyDataSize:UInt32 = UInt32(sizeof(Int64))
var frameSize:Int64 = 0
ExtAudioFileGetProperty(audioFileRef, kExtAudioFileProperty_FileLengthFrames, &ioPropertyDataSize, &frameSize)

print("Frame Size : \(frameSize)")


var format = AudioStreamBasicDescription()
var size:UInt32 = UInt32(sizeof(AudioStreamBasicDescription))
ExtAudioFileGetProperty(audioFileRef, kExtAudioFileProperty_FileDataFormat, &size, &format)

format

var ioNumberFrames:UInt32 = 128
var ioData = AudioBufferList()

let readFrameSize:UInt32 = 100
let bufferByteSize = format.mBytesPerFrame * readFrameSize * format.mBytesPerFrame
var buffer = UnsafeMutablePointer<Void>.alloc( Int(bufferByteSize) )
defer { buffer.dealloc(Int(bufferByteSize)) }

ioData.mNumberBuffers = 1
var audioBuffers = ioData.mBuffers
audioBuffers.mNumberChannels = format.mChannelsPerFrame
audioBuffers.mDataByteSize = bufferByteSize
audioBuffers.mData = buffer
ioData.mBuffers = audioBuffers

let readStatus = ExtAudioFileRead(audioFileRef, &ioNumberFrames, &ioData)

print(readStatus)
print(ioNumberFrames)
print(ioData)

print(ioData.mBuffers.mData[0])

var IntPtr: UnsafeMutablePointer<UInt16> = unsafeBitCast(ioData.mBuffers.mData, UnsafeMutablePointer<UInt16>.self)

for var i in 0..<ioNumberFrames {
    XCPlaygroundPage.currentPage.captureValue(IntPtr[Int(i)], withIdentifier: "Raw Wave")
}
