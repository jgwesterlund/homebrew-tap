class Mym < Formula
  desc "CLI for myMem — search, read and write your local notes from any agent"
  homepage "https://github.com/jgwesterlund/mymem"
  url "https://github.com/jgwesterlund/mymem/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "bb735bea677fb7fd037f0314abb5b1d9ac96d0890a156720552402fe72d6640f"
  license "MIT"

  depends_on "go" => :build

  def install
    cd "cli" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "."
    end
  end

  test do
    # Without the myMem app running there is no socket — the CLI must say so clearly.
    output = shell_output("#{bin}/mym status 2>&1", 2)
    assert_match "myMem is not running", output
  end
end
