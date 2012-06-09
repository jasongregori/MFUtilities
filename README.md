This repository is a set of useful **iOS** mini frameworks covering a broad range of uses to show you what a mini framework is and why they are useful.


Files
-----

- describe: Describe all mini frameworks in the current directory and all subdirectories
- MFBase64: Easily base64 encode strings or data
- MFKeychain: Easily and securely store whatever you want using the Keychain
- MFTimeSince: Gives you the time passed since a date as a string; fully and easily customizable
- NSMutableURLRequest+MFMultipart: Allows you to easily add multipart data to an NSMutableURLRequest
- NSURL+MFQueryParams: Create urls with query params or get query params from a url


Use
---

1. Find a mini framework that helps you
2. Grab it and copy it into your project
3. Use it

Just copy them directly into your project. Don't try to statically link or share mini frameworks between projects unless you really want to.

You are encouraged to manipulate mini frameworks in whatever way helps you. If you need to rename a file/class or add something specific to a mini framework for your current project, **do it**! When you start your next project, come back here and get a fresh copy.


Mini Frameworks
---------------

Mini Frameworks are extremely useful tiny frameworks which are entirely self contained. They follow these rules:

- Each mini framework consists of at most 2 files (a header and an implementation).
- A mini framework may not include other files with the exception of system frameworks and files. (*Mini Framework subclasses, though discouraged, may include their superclass*).

I hope others will create their own repositories with mini frameworks they find useful. For more information check out the [wiki](https://github.com/jasongregori/mini-frameworks/wiki).