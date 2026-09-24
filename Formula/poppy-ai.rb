class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/0c/55/577ad2025640e561ca619fbb944045aee55823ef85f5146780430f904647/poppy_ai-0.4.0.tar.gz"
  sha256 "89668cfb0843d03d0cccab6350e4374a8accbcb22444ffd21cb9e6e549c4e3f3"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
