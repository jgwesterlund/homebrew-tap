cask "mymem" do
  version "1.3.1"
  sha256 "8be9e3bffe65db988f4ea3f23d3ea5f4e84c5190ecc6469e0927fc2e3d82e289"

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
