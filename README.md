# SwiftHelpSet

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=57ab475fc5a84e0100f93dd2&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/57ab475fc5a84e0100f93dd2/build/latest)

Set of Swift utilities for your iOS apps

# Installation

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):

```ruby
pod 'SwiftHelpSet', '~> 1.0'
```

# Networking

The networking layer is built over two different objects: the `APIModule` conforming object and the `Resource`.
Conform to the `APIModule` protocol like below:


```swift
final class UserModule: APIModule {
    let baseAPIURL: String = "http://myserver.ext/api/user"

    func load<Object>(resource: Resource<Object>, completion: Completion<Object, NSError> -> ()) -> NSURLSession {

        // do the request, calling an API middleware
        // return the request
    }
}
```

Then, create your own resource

```swift
final class User {
    let id: String

    init(id: String) {
        self.id = id
    }
}

extension User {
    static var All: Resource<[User]> {
        return Resource(
            endpoint: Endpoint(
                path: "/",
                method: .GET,
                parameters: nil,
                headers: nil
            ),
            parseJSON: { json -> [User] in
                // parse the JSON
                // return the array of User
            }
        )
    }
}
```

Then call your `APIModule` as below

```swift
UserModule().load(User.All) { result in
    // switch over the Completion enum
}
```

Thanks to [@ChrisEidhof](https://twitter.com/chriseidhof) for the `Resource` idea.


# Bind

The help set allows you to create a more functional project by using the `Bindable` type.
Declare your public variable as

```swift
var currentUser = Bindable<User>(user)
```

Then, from your class, you can listen changes to the variable `currentUser` by doing

```swift
objectReference.currentUser.bind = { user in
    // Do something when the currentUser changes
}
```

# Foundation wrappers

Use `Permission` and `Purchase` to avoid the use of delegates for purchasing and for asking permissions. Use closures instead.

Use `NotificationCenter` to get a more powerful and smart wrapper around `NSNotificationCenter`

Use `Each` for a nice and easy implementation of `NSTimer`

```swift
Each(2).seconds.perform {
    // Do something
    return false    // true for stopping the timer, false for continuing
}

Each(1).minutes.perfor {
    // Do Something
}
```

# Foundation extensions

## Array

Use the method `get(at index: Int) -> Element?` on the array to secure get the element at index.
Added also the method `remove<T: Equatable>(object: T) -> Int?` that removes an equatable object from the array and returns the position if it was found

## String

New properties to get simply more info about the string: `isEmail`, `isPhoneNumber`, `isBlank`, `lenght` and even `localized` that returns the localized string for the key

## Int

Easily check if an `Int` value is in a range by using `isInRange(range: Range<Int>) -> Bool` method.

## Dictionary

Mix two dictionaries together by calling the `+=`, `+` operators

## NSDate

No more `.OrderedAscending` or `.OrderedSame` to compare two `NSDate` instances. You can use the operators `>`, `<`, `=`


# UIKit Wrappers

Use the `SwiftyTableView`, `SwiftyScrollView` and the `SwiftyTextField` to avoid the use of delegates as below

```swift
let tableView = SwiftyTableView().configureNumberOfSections {
    return 1
}.numberOfRowsPerSection { section in
    return 2
}.cellForIndexPath { indexPath, tableView in
    return UITableViewCell()
}
```


## CABasicAnimation wrapper

Create your own animation easily. The wrapper allows you to create simple rotation animations only, but you can easily extend it.

```swift
let animation = BasicAnimation.rotationAnimation(on: .z, duration: 1).onStart {
    // do something at the start of the animation
}.onStop { finished in
    // do something at the end
    animation.remove()
}.add(to: layer)
```

## Generic Table View Controller

Create your own table view controller easily, just passing a valid set of data

```swift
let genericTable = SwiftyGenericTableViewController<MyTableViewCell, User>()

genericTable.cellForModel { cell, model in
    // setup the cell
    return cell
}.onSelection { indexPath, model in
    // push or do something
}.dataSource = userArray
```

## UIControl Extension

Define your action on `UIControl` trigger without using the ugly syntax `addTarget(...)`.

```swift
let button = UIButton(frame: .zero)
button.bind(.TouchUpInside) {
    // Do something
}
```

## UIBarButtonItem Extension

Define your `UIBarButtonItem` easily by providing a closure instead of a selector.

```swift
let item = UIBarButtonItem.itemWith(title: "BUTTON") {
    // do something on tap
}
```

## UIGestureRecognizer extension

Easily define the `UIGestureRecognizer` by providing a closure instead of a selector

```swift
let tapRecognizer = UITapGestureRecognizer.recognizerPerforms {
    // Do something on tap
}.numberOfTapsRequired = 1
```