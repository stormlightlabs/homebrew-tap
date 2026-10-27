class Arcl < Formula
  desc "Local-first project planning for developers and their agents"
  homepage "https://github.com/stormlightlabs/arclightning"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.3.0/arcl-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7cf3c94e04bac6c9dff4fd357fc8133050fe0dbbca9d4d1dab2e4ecd8c5e13c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.3.0/arcl-cli-x86_64-apple-darwin.tar.xz"
      sha256 "345fc9405dda66372df32188592d9c920f4989353e1cd8df7b30b2be7de39efc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.3.0/arcl-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2b8d006f1a5a61bfd181c4169c71c14c1060ee468118c2bf9fcad9bee43dca54"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stormlightlabs/arclightning/releases/download/v0.3.0/arcl-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "80f6bc7e4ce41f7037c91330c814d94e277aed381d192960d00a130a859675e3"
    end
  end

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
