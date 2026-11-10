class Psychic < Formula
  desc "Smarter file explorer and cd replacement that learns from your actions and ranks files with a model trained on your machine"
  homepage "https://github.com/kshitijl/psychic"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.0/psychic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8f1145201b0662d694ac422099d1d47a3490f9408620336fa5d988bb3c72f815"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.0/psychic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f4ff3e462def0cca54fb10586f43042cb42d00b4328462628abb09c20ebe9671"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.0/psychic-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8e1ba829ced469bdd5b9f62eddef054fdbb39a1d240d0e46ef725960835a9a58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.0/psychic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f058be0b9e1ba44a3b8e83dd28517c647aeea00ce5e4d57230103970bb29813"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "psychic"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "psychic"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "psychic"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "psychic"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
