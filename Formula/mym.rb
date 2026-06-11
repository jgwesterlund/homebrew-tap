class Mym < Formula
  desc "CLI for myMem — search, read and write your local notes from any agent"
  homepage "https://github.com/jgwesterlund/mymem"
  url "https://github.com/jgwesterlund/mymem/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "fff79c6d9f53a6acf6df9f309e21d2560ad979658e3edb090f6f25c1b376d18b"
  license "MIT"

  depends_on "go" => :build

  def install
    cd "cli" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "."
    end
  end

  test do
    # Point at a dead socket so the test is deterministic even when the
    # myMem app happens to be running on the build machine.
    ENV["MYMEM_SOCKET"] = (testpath/"none.sock").to_s
    output = shell_output("#{bin}/mym status 2>&1", 2)
    assert_match "myMem is not running", output
  end
end
