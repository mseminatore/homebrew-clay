# Installs the prebuilt release archives from github.com/mseminatore/clay.
# Updated by the clay release workflow (url/sha256/version); see README.md.
class Clay < Formula
  desc "Prototype-based, pure object-oriented language compiling to C or bytecode"
  homepage "https://github.com/mseminatore/clay"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.13/clay-0.3.13-macos-arm64.tar.gz"
      sha256 "b97f72202c86ca80c6167b3012136c01522a62462220716026017a656f33d630"
    end
    on_intel do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.13/clay-0.3.13-macos-x86_64.tar.gz"
      sha256 "ec08f4382119777fb2a0a0c9d6b5719ea02f8bdffe75cf18cbb14de3ccd5d7be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.13/clay-0.3.13-linux-arm64.tar.gz"
      sha256 "2bdbd47208ac6ca35fdadd77c59139cca35ece3cd7240a0345c31d24dd56c7e4"
    end
    on_intel do
      url "https://github.com/mseminatore/clay/releases/download/v0.3.13/clay-0.3.13-linux-x86_64.tar.gz"
      sha256 "eaf16b20d18ddf8d081b24d6a0f72b339eb433bf0fd2914ef9a3c0cf592b34b6"
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
