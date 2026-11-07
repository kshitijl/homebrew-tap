class Psychic < Formula
  desc "Smarter file explorer and cd replacement that learns from your actions and ranks files with a model trained on your machine"
  homepage "https://github.com/kshitijl/psychic"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.3.0/psychic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d9174dbc8e7445812f459354d66b515976c73fa238bc883e715cbc3f97299183"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.3.0/psychic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9c36dd72b40ba0a2ec78f9b88acad9e9b64c03963ba143bed2076d5763a3b503"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kshitijl/psychic/releases/download/v0.3.0/psychic-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a85b3d97b54fb2e17f04b0eda177bb819f73211ba4e59a649e223b20e9db18fe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kshitijl/psychic/releases/download/v0.3.0/psychic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dcc28e79497ac67eeacf3a624a3faf185eea5cdff7e732d3d15c5228191323e3"
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
