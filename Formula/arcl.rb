class Arcl < Formula
  desc "Local-first project planning for developers and their agents"
  homepage "https://github.com/stormlightlabs/arclightning"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.4.1/arcl-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6e75955869641c8bff0502d7cfe6c32af264ef1a5b1ee9afe62d7817856c9283"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.4.1/arcl-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f6d2477f14a5505c9c69f5a98b9b8195bd815e3f66410fe7fd04f468f091b553"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.4.1/arcl-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a5d403570dd2b4ec17a6224ea703fa70eed946af2db0de8a876f6cad5a3a0517"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.4.1/arcl-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a3ea989366e37376742f7e64e252f0e198f0a11f689be95761d4ca4c0d37f546"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "arcl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "arcl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "arcl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "arcl"
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
