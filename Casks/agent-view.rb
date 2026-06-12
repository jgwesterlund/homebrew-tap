cask "agent-view" do
  version "0.1.0"
  sha256 "c55272fa2edaf79bbb94fcfcd63d38c0ff82fc2a5593fb0b3df96e777adf497a"

  url "https://github.com/jgwesterlund/agent-view/releases/download/v#{version}/AgentView-#{version}-arm64.zip",
      verified: "github.com/jgwesterlund/agent-view/"
  name "Agent View"
  desc "Cyberpunk pixel-art office that visualises your herdr AI agents"
  homepage "https://github.com/jgwesterlund/agent-view"

  livecheck do
    url :url
    strategy :github_latest
  end

  # arm64-only build; Apple Silicon implies macOS >= 11 by definition.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Agent View.app"

  # The app is ad-hoc signed but not notarized. Strip Homebrew's quarantine
  # flag so it launches without the Gatekeeper "damaged / can't be opened"
  # prompt (Homebrew no longer offers --no-quarantine).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "-r", "com.apple.quarantine", "#{appdir}/Agent View.app"],
                   sudo: false
  end

  uninstall quit: "com.cygnisec.agentview"

  zap trash: [
    "~/Library/Application Support/Agent View",
    "~/Library/Application Support/com.cygnisec.agentview",
    "~/Library/Caches/com.cygnisec.agentview",
    "~/Library/HTTPStorages/com.cygnisec.agentview",
    "~/Library/Preferences/com.cygnisec.agentview.plist",
    "~/Library/Saved Application State/com.cygnisec.agentview.savedState",
    "~/Library/WebKit/com.cygnisec.agentview",
  ]

  caveats <<~EOS
    Agent View is ad-hoc signed but not notarized. The cask clears the
    quarantine flag automatically. If macOS still blocks the first launch,
    run:
      xattr -dr com.apple.quarantine "/Applications/Agent View.app"

    Agent View reads agent state from herdr (https://herdr.dev) — install
    and run herdr to see your agents in the room.
  EOS
end
