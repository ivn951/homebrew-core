class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.35.10.tar.gz"
  sha256 "8ce2f01c187c9c489fe7a664980f5cb4d07822cb5e84eb8bf0230d3caac775fb"
  head "https://github.com/nicklockwood/SwiftFormat.git", :shallow => false

  bottle do
    cellar :any_skip_relocation
    sha256 "4694f51a6e91f15d211322bd5636427cf766a2d70455a3bd2cb957ad027fd4c9" => :mojave
    sha256 "999d3efc89596a0bcd11e9849103caea26af686075dcd5f43532f570abb5535f" => :high_sierra
    sha256 "dbfc8f92de9e9c0da9a0e571f25070d4178e4ae332df0eb4686d4a4179bba1cf" => :sierra
  end

  depends_on :xcode => ["9.2", :build]

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end
