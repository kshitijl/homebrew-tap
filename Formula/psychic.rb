class Psychic < Formula
  desc "Smarter file explorer and cd replacement that learns from your actions and ranks files with a model trained on your machine"
  homepage "https://github.com/kshitijl/psychic"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.2.0/psychic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f99f1bd235a01a0fa692fd64fb23c51883cb3a24e7614dcfc6f8d88979cf24b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.2.0/psychic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cdb03197d7d542046292126afcd16e1d98b44495a62d0dcf7afe1d171eb97d16"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.2.0/psychic-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "781cba2f5961b66a888a714599f5c650a2a96216039a74911f7f0692054c8258"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.2.0/psychic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb77480587c185c36ab74a25f7c15db48fcbc0209afbe599a1869c30ab964a93"
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
