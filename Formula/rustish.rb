class Rustish < Formula
  desc "Modern shell with smart completions, 2ms startup, and 70+ builtins"
  homepage "https://github.com/rodrigodealer/rustish"
  url "https://github.com/rodrigodealer/rustish/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e719d31946f432e3c92875a16ab0466f9301620166bbe3bc2ca27ab19b06b13b"
  license "MIT"
  head "https://github.com/rodrigodealer/rustish.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Man page
    man1.install "doc/rustish.1"

    # Shell completions
    bash_completion.install "completions/rustish.bash" => "rustish"
    zsh_completion.install "completions/_rustish"
    fish_completion.install "completions/rustish.fish"
  end

  def post_install
    ohai "To set rustish as your default shell:"
    ohai "  echo #{HOMEBREW_PREFIX}/bin/rustish | sudo tee -a /etc/shells"
    ohai "  chsh -s #{HOMEBREW_PREFIX}/bin/rustish"
  end

  test do
    assert_match "rustish", shell_output("#{bin}/rustish --help")
    assert_equal "hello\n", shell_output("#{bin}/rustish -c 'echo hello'")
    assert_equal "4\n", shell_output("#{bin}/rustish -c 'math 2+2'")
  end
end
