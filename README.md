wrapper app bundle for qutebrowser

macOS clusterfucks everything you have to do this just to get
it recognized as a browser/url handler

```sh
brew install Francesco149/homebrew-tap/qutebrowser
cp -r /usr/local/opt/qutebrowser/MacQutebrowser.app /Applications
```

and now you can set MacQutebrowser as your default browser and
run it from spotlight

technically the brew tap will install this but you can compile
from source if you want

```sh
brew install xcodegen
git clone --recursive https://github.com/Francesco149/MacQutebrowser
cd MacQutebrowser
xcodegen && xcodebuild -configuration Release
rm -rf /Applications/MacQutebrowser.app
cp -r build/Release/MacQutebrowser.app /Applications
```

if the application doesn't register/show up, try running

```sh
/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user
```
