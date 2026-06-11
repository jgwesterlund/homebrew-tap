cask "mymem" do
  version "1.1.1"
  sha256 "3d6c7d634d7603b716d1d34b2c294164d1ceee962a9fae6ee979b99f3d5128dc"

  url "https://github.com/jgwesterlund/mymem/releases/download/v#{version}/myMem-#{version}-arm64.dmg"
  name "myMem"
  desc "Local-first AI notes app — your notes, your models"
  homepage "https://github.com/jgwesterlund/mymem"

  # arm64-only build; Apple Silicon implies macOS >= 11 by definition.
  depends_on :macos
  depends_on arch: :arm64

  app "myMem.app"

  zap trash: [
    "~/Library/Application Support/myMem",
    "~/Library/Preferences/com.westerlund.mymem.plist",
    "~/Library/Saved Application State/com.westerlund.mymem.savedState",
  ]

  caveats <<~EOS
    myMem is currently unsigned, so macOS Gatekeeper blocks the first launch.
    Right-click /Applications/myMem.app and choose "Open" (needed once), or:
      xattr -dr com.apple.quarantine /Applications/myMem.app
  EOS
end
