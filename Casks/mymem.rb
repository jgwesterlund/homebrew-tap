cask "mymem" do
  version "1.2.0"
  sha256 "53e7fd0015776489db1893c04ece7f298c1c03f3eef8a4ae9921820486f45884"

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
