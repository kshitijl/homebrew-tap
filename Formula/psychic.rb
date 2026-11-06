class Psychic < Formula
  desc "Smarter file explorer and cd replacement that learns from your actions and ranks files with a model trained on your machine"
  homepage "https://github.com/kshitijl/psychic"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.1.0/psychic-aarch64-apple-darwin.tar.xz"
      sha256 "136da2ccc73507ce8620c691a83f17e8913b968fe4a153b5a1e4dba61d5b9272"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.1.0/psychic-x86_64-apple-darwin.tar.xz"
      sha256 "92d78f89e0c453417d6ede693e496af03d4949c60678a5a5fdad6f0a13ede9c9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.1.0/psychic-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb061cd810236a975a0e493f5ba0be8d8e2be3e2d3e2525929312dc5b79fd056"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.1.0/psychic-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbb8bb1633b6a91a5f74dc4e3a9466e1ff58eea21bdeb7f7dfa89c7864cbf99a"
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
