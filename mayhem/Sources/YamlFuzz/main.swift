#if canImport(Darwin)
import Darwin.C
#elseif canImport(Glibc)
import Glibc
#elseif canImport(MSVCRT)
import MSVCRT
#endif

import Foundation
import Yaml

@_cdecl("LLVMFuzzerTestOneInput")
public func YamlFuzz(_ start: UnsafeRawPointer, _ count: Int) -> CInt {
    let fdp = FuzzedDataProvider(start, count)
    do {
        try Yaml.load(fdp.ConsumeRemainingString())
        return 0
    }
    catch _ as Yaml.ResultError {
        return -1
    }
    catch let error {
        print(error)
        print(type(of: error))
        exit(EXIT_FAILURE)
    }
}