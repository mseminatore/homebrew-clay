# Installs the prebuilt release archives from github.com/mseminatore/clay.
# Updated by the clay release workflow (url/sha256/version); see README.md.
class ClayLang < Formula
  desc "Prototype-based, pure object-oriented language compiling to C or bytecode"
  homepage "https://github.com/mseminatore/clay"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.14/clay-0.3.14-macos-arm64.tar.gz"
      sha256 "d6ada75505e0245c576f66bb601286eb2556991cc61d6a728de12649f2f00671"
    end
    on_intel do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.14/clay-0.3.14-macos-x86_64.tar.gz"
      sha256 "51da0693228e138bc46eb9643a082071acc4ac450f6d140e3638074a682bdd32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.14/clay-0.3.14-linux-arm64.tar.gz"
      sha256 "53377dc8c10cf095a8cf8045101ac7aea76d56b90c34d2dfc54d8294c18fa758"
    end
    on_intel do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.14/clay-0.3.14-linux-x86_64.tar.gz"
      sha256 "e272ed4a6cd0c9e6d7951080deae2dde2f6ef126f46c0f2a05bf11d01d0a6bd4"
    end
  end

  def install
    # The archive is bin/clay + lib/clay/{stdlib,web,native} + share/doc/clay;
    # clay finds lib/clay relative to its resolved (Cellar) path.
    prefix.install Dir["*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clay --version")
    (testpath/"t.clay").write <<~CLAY
      import("stdlib/json")
      (Json stringify([1, 2])) println
      (3 + 4) println
    CLAY
    assert_match "7", shell_output("#{bin}/clay t.clay")
    system bin/"clay", "--compile", "-o", "t", "t.clay"
    assert_match "7", shell_output("./t")
  end
end
