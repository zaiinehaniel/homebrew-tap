cask "evict" do
  version "0.4.0"
  sha256 "767603a462aa800c498153d049ff6244a0fba96d76902d94368b8bd28bd315be"

  url "https://github.com/zaiinehaniel/evict/releases/download/v#{version}/Evict.zip"
  name "Evict"
  desc "Menu bar app that shows what idle apps cost in memory and closes them"
  homepage "https://github.com/zaiinehaniel/evict"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Evict.app"

  # Evict is free and not notarized by Apple; clear the quarantine flag so
  # macOS opens it without the "can't be opened" prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Evict.app"],
        writable_paths: ["Evict.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  uninstall quit: "com.hanielcortes.evict"

  zap trash: "~/Library/Preferences/com.hanielcortes.evict.plist"
end
