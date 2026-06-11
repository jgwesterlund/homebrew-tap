class Mym < Formula
  desc "CLI for myMem — search, read and write your local notes from any agent"
  homepage "https://github.com/jgwesterlund/mymem"
  url "https://github.com/jgwesterlund/mymem/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "d1e7bc0ead564557682074ec53c2efec2eba675614b22a2cf70df4d3d6818294"
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
