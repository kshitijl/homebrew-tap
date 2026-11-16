class Psychic < Formula
  desc "Smarter file explorer and cd replacement that learns from your actions and ranks files with a model trained on your machine"
  homepage "https://github.com/kshitijl/psychic"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.1/psychic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6b529d708c8cd18d9c2ee76842071c31bae4da58c1912cdda28eaddc8dd3c161"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.1/psychic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "757d1d650b7a8408a7576fd92d21e7c7588a40d5fa9cb5b91d744d4328ec4880"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.1/psychic-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0163e781f0c14292d794dc4c6584fb289b34b979b312d0d04e571a41b00d582b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.4.1/psychic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ddab3e8ccb6a68e8e82538e420dcc1db957feef2f90836da89f7dd40198c72d9"
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
