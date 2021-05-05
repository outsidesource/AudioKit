// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Physical model approximating the sound of a struck metal bar
/// 
public class MetalBar: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "mbar"
    public static let ComponentDescription = AudioComponentDescription(generator: "mbar")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = InternalAU

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for leftBoundaryCondition
    public static let leftBoundaryConditionDef = NodeParameterDef(
        identifier: "leftBoundaryCondition",
        name: "Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free",
        address: akGetParameterAddress("MetalBarParameterLeftBoundaryCondition"),
        range: 1 ... 3,
        unit: .hertz,
        flags: .default)

    /// Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free
    @Parameter public var leftBoundaryCondition: AUValue

    /// Specification details for rightBoundaryCondition
    public static let rightBoundaryConditionDef = NodeParameterDef(
        identifier: "rightBoundaryCondition",
        name: "Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free",
        address: akGetParameterAddress("MetalBarParameterRightBoundaryCondition"),
        range: 1 ... 3,
        unit: .hertz,
        flags: .default)

    /// Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free
    @Parameter public var rightBoundaryCondition: AUValue

    /// Specification details for decayDuration
    public static let decayDurationDef = NodeParameterDef(
        identifier: "decayDuration",
        name: "30db decay time (in seconds).",
        address: akGetParameterAddress("MetalBarParameterDecayDuration"),
        range: 0 ... 10,
        unit: .hertz,
        flags: .default)

    /// 30db decay time (in seconds).
    @Parameter public var decayDuration: AUValue

    /// Specification details for scanSpeed
    public static let scanSpeedDef = NodeParameterDef(
        identifier: "scanSpeed",
        name: "Speed of scanning the output location.",
        address: akGetParameterAddress("MetalBarParameterScanSpeed"),
        range: 0 ... 100,
        unit: .hertz,
        flags: .default)

    /// Speed of scanning the output location.
    @Parameter public var scanSpeed: AUValue

    /// Specification details for position
    public static let positionDef = NodeParameterDef(
        identifier: "position",
        name: "Position along bar that strike occurs.",
        address: akGetParameterAddress("MetalBarParameterPosition"),
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Position along bar that strike occurs.
    @Parameter public var position: AUValue

    /// Specification details for strikeVelocity
    public static let strikeVelocityDef = NodeParameterDef(
        identifier: "strikeVelocity",
        name: "Normalized strike velocity",
        address: akGetParameterAddress("MetalBarParameterStrikeVelocity"),
        range: 0 ... 1_000,
        unit: .generic,
        flags: .default)

    /// Normalized strike velocity
    @Parameter public var strikeVelocity: AUValue

    /// Specification details for strikeWidth
    public static let strikeWidthDef = NodeParameterDef(
        identifier: "strikeWidth",
        name: "Spatial width of strike.",
        address: akGetParameterAddress("MetalBarParameterStrikeWidth"),
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Spatial width of strike.
    @Parameter public var strikeWidth: AUValue

    // MARK: - Audio Unit

    /// Internal Audio Unit for MetalBar
    public class InternalAU: AudioUnitBase {
        /// Get an array of the parameter definitions
        /// - Returns: Array of parameter definitions
        public override func getParameterDefs() -> [NodeParameterDef] {
            [MetalBar.leftBoundaryConditionDef,
             MetalBar.rightBoundaryConditionDef,
             MetalBar.decayDurationDef,
             MetalBar.scanSpeedDef,
             MetalBar.positionDef,
             MetalBar.strikeVelocityDef,
             MetalBar.strikeWidthDef]
        }

        /// Create the DSP Refence for this node
        /// - Returns: DSP Reference
        public override func createDSP() -> DSPRef {
            akCreateDSP("MetalBarDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this Bar node
    ///
    /// - Parameters:
    ///   - leftBoundaryCondition: Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free
    ///   - rightBoundaryCondition: Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free
    ///   - decayDuration: 30db decay time (in seconds).
    ///   - scanSpeed: Speed of scanning the output location.
    ///   - position: Position along bar that strike occurs.
    ///   - strikeVelocity: Normalized strike velocity
    ///   - strikeWidth: Spatial width of strike.
    ///   - stiffness: Dimensionless stiffness parameter
    ///   - highFrequencyDamping: High-frequency loss parameter. Keep this small
    ///
    public init(
        leftBoundaryCondition: AUValue = 1,
        rightBoundaryCondition: AUValue = 1,
        decayDuration: AUValue = 3,
        scanSpeed: AUValue = 0.25,
        position: AUValue = 0.2,
        strikeVelocity: AUValue = 500,
        strikeWidth: AUValue = 0.05,
        stiffness: AUValue = 3,
        highFrequencyDamping: AUValue = 0.001
    ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.leftBoundaryCondition = leftBoundaryCondition
            self.rightBoundaryCondition = rightBoundaryCondition
            self.decayDuration = decayDuration
            self.scanSpeed = scanSpeed
            self.position = position
            self.strikeVelocity = strikeVelocity
            self.strikeWidth = strikeWidth
        }

    }

    // MARK: - Control

    /// Trigger the sound with current parameters
    ///
    open func trigger() {
        internalAU?.start()
        internalAU?.trigger()
    }

}
