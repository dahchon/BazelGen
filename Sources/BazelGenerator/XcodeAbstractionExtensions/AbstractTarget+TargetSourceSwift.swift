//
// AbstractTarget+TargetSourceSwift.swift
// Copyright (c) 2023 Daohan Chong and other XcodeMigrate authors.
// MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the  Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED  AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import PathKit
import XcodeAbstraction

extension AbstractTarget {
    func targetSourceSwift(projectRoot: Path) -> BazelRule {
        let sourceName = "\(name)_source"
        let srcs = sourcePathStrings(projectRoot: projectRoot)
        let deps = dependencyLabels(projectRoot: projectRoot).map { dependencyLabel in
            dependencyLabel + AbstractTargetBazelGenConstants.frameworkLibSuffix
        }
        let moduleName = name
        let targetSource: BazelRule

        switch productType {
        case .unitTestBundle, .uiTestBundle:
            targetSource = .swiftTest(
                name: sourceName,
                srcs: srcs,
                deps: deps,
                moduleName: moduleName
            )
        default:
            targetSource = .swiftLibrary(
                name: sourceName,
                srcs: srcs,
                deps: deps,
                moduleName: moduleName
            )
        }

        return targetSource
    }
}