// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation

/// AudioKit version of Apple's DynamicsProcessor Audio Unit
///
public class DynamicsProcessor: Node {

    fileprivate let effectAU = AVAudioUnitEffect(appleEffect: kAudioUnitSubType_DynamicsProcessor)

    let input: Node

    /// Connected nodes
    public var connections: [Node] { [input] }

    /// Underlying AVAudioNode
    public var avAudioNode: AVAudioNode { effectAU }

    /// Specification details for threshold
    public static let thresholdDef = NodeParameterDef(
        identifier: "threshold",
        name: "Threshold",
        address: AUParameterAddress(kDynamicsProcessorParam_Threshold),
        defaultValue: -20,
        range: -40 ... 20,
        unit: .decibels)

    /// Threshold (decibels) ranges from -40 to 20 (Default: -20)
    @Parameter(thresholdDef) public var threshold: AUValue

    /// Specification details for headRoom
    public static let headRoomDef = NodeParameterDef(
        identifier: "headRoom",
        name: "Head Room",
        address: AUParameterAddress(kDynamicsProcessorParam_HeadRoom),
        defaultValue: 5,
        range: 0.1 ... 40.0,
        unit: .decibels)

    /// Head Room (decibels) ranges from 0.1 to 40.0 (Default: 5)
    @Parameter(headRoomDef) public var headRoom: AUValue

    /// Specification details for expansionRatio
    public static let expansionRatioDef = NodeParameterDef(
        identifier: "expansionRatio",
        name: "Expansion Ratio",
        address: AUParameterAddress(kDynamicsProcessorParam_ExpansionRatio),
        defaultValue: 2,
        range: 1 ... 50.0,
        unit: .rate)

    /// Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    @Parameter(expansionRatioDef) public var expansionRatio: AUValue

    /// Specification details for expansionThreshold
    public static let expansionThresholdDef = NodeParameterDef(
        identifier: "expansionThreshold",
        name: "Expansion Threshold",
        address: AUParameterAddress(kDynamicsProcessorParam_ExpansionThreshold),
        defaultValue: 2,
        range: 1 ... 50.0,
        unit: .decibels)

    /// Expansion Threshold (decibels) ranges from 1 to 50.0 (Default: 2)
    @Parameter(expansionThresholdDef) public var expansionThreshold: AUValue

    /// Specification details for attackTime
    public static let attackTimeDef = NodeParameterDef(
        identifier: "attackTime",
        name: "Attack Time",
        address: AUParameterAddress(kDynamicsProcessorParam_AttackTime),
        defaultValue: 0.001,
        range: 0.0001 ... 0.2,
        unit: .seconds)

    /// Attack Time (seconds) ranges from 0.0001 to 0.2 (Default: 0.001)
    @Parameter(attackTimeDef) public var attackTime: AUValue

    /// Specification details for releaseTime
    public static let releaseTimeDef = NodeParameterDef(
        identifier: "releaseTime",
        name: "Release Time",
        address: AUParameterAddress(kDynamicsProcessorParam_ReleaseTime),
        defaultValue: 0.05,
        range: 0.01 ... 3,
        unit: .seconds)

    /// Release Time (seconds) ranges from 0.01 to 3 (Default: 0.05)
    @Parameter(releaseTimeDef) public var releaseTime: AUValue

    /// Specification details for masterGain
    public static let masterGainDef = NodeParameterDef(
        identifier: "masterGain",
        name: "Master Gain",
        address: AUParameterAddress(6),
        defaultValue: 0,
        range: -40 ... 40,
        unit: .decibels)

    /// Master Gain (decibels) ranges from -40 to 40 (Default: 0)
    @Parameter(masterGainDef) public var masterGain: AUValue

    /// Compression Amount (dB) read only
    public var compressionAmount: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[7].value ?? 0
    }

    /// Input Amplitude (dB) read only
    public var inputAmplitude: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[8].value ?? 0
    }

    /// Output Amplitude (dB) read only
    public var outputAmplitude: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[9].value ?? 0
    }
    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the dynamics processor node
    ///
    /// - parameter input: Input node to process
    /// - parameter threshold: Threshold (decibels) ranges from -40 to 20 (Default: -20)
    /// - parameter headRoom: Head Room (decibels) ranges from 0.1 to 40.0 (Default: 5)
    /// - parameter expansionRatio: Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    /// - parameter expansionThreshold: Expansion Threshold (decibels) ranges from 1 to 50.0 (Default: 2)
    /// - parameter attackTime: Attack Time (seconds) ranges from 0.0001 to 0.2 (Default: 0.001)
    /// - parameter releaseTime: Release Time (seconds) ranges from 0.01 to 3 (Default: 0.05)
    /// - parameter masterGain: Master Gain (decibels) ranges from -40 to 40 (Default: 0)
    ///
    public init(
        _ input: Node,
        threshold: AUValue = thresholdDef.defaultValue,
        headRoom: AUValue = headRoomDef.defaultValue,
        expansionRatio: AUValue = expansionRatioDef.defaultValue,
        expansionThreshold: AUValue = expansionThresholdDef.defaultValue,
        attackTime: AUValue = attackTimeDef.defaultValue,
        releaseTime: AUValue = releaseTimeDef.defaultValue,
        masterGain: AUValue = masterGainDef.defaultValue) {
        self.input = input

        associateParams(with: effectAU)

        self.threshold = threshold
        self.headRoom = headRoom
        self.expansionRatio = expansionRatio
        self.expansionThreshold = expansionThreshold
        self.attackTime = attackTime
        self.releaseTime = releaseTime
        self.masterGain = masterGain
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
