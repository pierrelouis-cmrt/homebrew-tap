class Soji < Formula
  desc "Disk cleanup for macOS in the terminal, with layered safety checks"
  homepage "https://github.com/pierrelouis-cmrt/soji"
  url "https://github.com/pierrelouis-cmrt/soji/releases/download/v0.4.0/soji.pyz"
  version "0.4.0"
  sha256 "d57e01c754c18475567830373bbb6d4899d7b2e58c88b072253d72a5eb296213"

  depends_on :macos
  # 3.14+ adds compression.zstd, used to read compressed Codex sessions.
  depends_on "python@3.14"

  def install
    libexec.install "soji.pyz"
    (bin/"soji").write <<~SH
      #!/bin/sh
      exec "#{Formula["python@3.14"].opt_bin}/python3.14" "#{libexec}/soji.pyz" "$@"
    SH
    chmod 0755, bin/"soji"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/soji --version")
  end
end
