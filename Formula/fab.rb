class Fab < Formula
  desc "A software factory that takes tasks to reviewed pull requests"
  homepage "https://github.com/stormlightlabs/fabrial"
  version "0.9.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/stormlightlabs/fabrial/releases/download/v0.9.1/fab-cli-aarch64-apple-darwin.tar.xz"
    sha256 "af096b23238b217b1c5a5274f16af164632bc7a45fbce39ce2f3d86191851be7"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/stormlightlabs/fabrial/releases/download/v0.9.1/fab-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "6472cf6f53b655aafdd09d08e0bda4e2606d2519a21afae34f9caee88e67bf97"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-unknown-linux-gnu": {},
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
      bin.install "fab"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fab"
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
