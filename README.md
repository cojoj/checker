# Checker

Tool for **checking** (obviously) whether your computer is ready for **iOS development**.
The main purpose of this script is to give it to **workshop attendees**, so you can peacefully jump straight to workshops without any additional hustle around their computers to check all necessary tools 🙌.

Right now this script is checking:

1. Presence of **Xcode**
2. Version of **Xcode**
3. Presence of **git**
4. Version of **ruby**
5. Presence of **CocoaPods**

### Usage 🛠

To simply run this command you have to:
```bash
curl -s https://github.com/cojoj/checker/checker.sh | sh
```

Of course you can clone repository, modify something and adjust this script to your needs.
First step int customisation may be **versions** of software you want to check. So far there are only two of those:

+ `MIN_XCODE_VERSION`
+ `MIN_RUBY_VERSION`
