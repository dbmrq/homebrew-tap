class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/01/f4/c229ba2a7943d280a8f781f7c09452de5a3426df0a7b48f0a492d5c54699/poppy_ai-0.5.0.tar.gz"
  sha256 "9319ea05c41842e4e92a5161bd0b4dc2b93fb785e12010265bbc12c00915c1c8"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
