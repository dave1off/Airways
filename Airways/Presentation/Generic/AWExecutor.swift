import Foundation

final class AWExecutor {
    
    static func executeOnMain(block: @escaping () -> ()) {
        DispatchQueue.main.async(execute: block)
    }

}
