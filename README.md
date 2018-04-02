#  PwnedKit

Swift framework and tool to check passwords against the [Have I Been Pwned](https://haveibeenpwned.com/Passwords) API.

## Requirements

`PwnedKit` requires Swift 4.0 or later and has been tested both on macOS and Linux.

## Usage

`PwnedTool` is Command Line tool that will show you how many occurrences of each input password are found in the HIBP database:

    $ swift run PwnedTool -i passw0rd Secure5
    [*] passw0rd
    [ ] Occurrences: 200297
    [*] Secure5
    [ ] Occurrences: 2

## Important

This library never sends the password over the network nor does it store the passwords processed. You can read about how it works [here](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/#cloudflareprivacyandkanonymity).

## Authors

- Initial version as [`PwnedPasswords`](https://github.com/foffer/PwnedPasswords): [foffer](https://github.com/foffer)
- Current version as `PwnedKit` and Swift PM support: [pvieito](https://twitter.com/pvieito)

## License

`PwnedKit` is available under the MIT license. See the LICENSE file for more info.
