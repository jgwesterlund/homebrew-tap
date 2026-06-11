cask "mymem" do
  version "1.1.0"
  sha256 "368bbbfe46cce6c7e9f0b6d7a5497a1e6234cbeac900b3abdc4eef8850c93659"

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
    myMem is currently unsigned. macOS Gatekeeper will block the first launch
    unless you either install with:
      brew install --cask mymem --no-quarantine
    or right-click the app and choose "Open" the first time.
  EOS
end
