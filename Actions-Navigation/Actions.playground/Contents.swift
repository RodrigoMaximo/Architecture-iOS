import UIKit

// -------------------------------------------------------------------------------------

protocol Action: Decodable {
    func scene() -> UIViewController
}

enum ActionIdentifier: String, Decodable {
    case home = "HOME"
    case screenOne = "SCREEN_ONE"
    case screenTwo = "SCREEN_TWO"

    var metatype: Action.Type {
        switch self {
        case .home:
            return HomeAction.self
        case .screenOne:
            return ScreenOneAction.self
        case .screenTwo:
            return ScreenTwoAction.self
        }
    }
}

// -------------------------------------------------------------------------------------

struct HomeAction: Action {
    func scene() -> UIViewController {
        return HomeCoordinator.scene()
    }
}

struct ScreenOneAction: Action {
    let title: String

    func scene() -> UIViewController {
        return ScreenOneCoordinator.scene(title: self.title)
    }
}

struct ScreenTwoAction: Action {
    let title: String
    let subtitle: String

    func scene() -> UIViewController {
        return ScreenTwoCoordinator.scene(title: self.title, subtitle: self.subtitle)
    }
}

// -------------------------------------------------------------------------------------

protocol Coordinator {}

final class HomeCoordinator: Coordinator {
    static func scene() -> UIViewController {
        // Create all the architecture and dependencies here
        return UIViewController()
    }
}

final class ScreenOneCoordinator: Coordinator {
    static func scene(title: String) -> UIViewController {
        // Create all the architecture and dependencies here
        return UIViewController()
    }
}

final class ScreenTwoCoordinator: Coordinator {
    static func scene(title: String, subtitle: String) -> UIViewController {
        // Create all the architecture and dependencies here
        return UIViewController()
    }
}

// -------------------------------------------------------------------------------------

final class AnyAction: Decodable {

    private enum CodingKeys: CodingKey {
        case identifier
    }

    let action: Action?

    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(ActionIdentifier.self, forKey: .identifier)
            self.action = try type.metatype.init(from: decoder)
        } catch {
            self.action = nil
        }
    }
}

// -------------------------------------------------------------------------------------

struct ResponseModelForActions: Decodable {
    private enum CodingKeys: CodingKey {
        case action, text
    }

    let action: Action?
    let text: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        let anyAction = try? container.decode(AnyAction.self, forKey: .action)
        self.action = anyAction?.action
    }
}

// -------------------------------------------------------------------------------------

extension Coordinator {
    func scene(using action: Action) -> UIViewController {
        return action.scene()
    }
}

// -------------------------------------------------------------------------------------

//{
//    "text": "Demonstrative text",
//    "action": {
//        "identifier": "SCREEN_ONE",
//        "title": "Example of title"
//    }
//}
