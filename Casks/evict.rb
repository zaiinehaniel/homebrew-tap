cask "evict" do
  version "0.1.0"
  sha256 "15ecbaea289dcacfd5431825b4e99e813f2ed32b87b36e52dd26dd005260415d"

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
