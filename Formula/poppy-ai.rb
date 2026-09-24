class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/c3/fe/5693aa7ab932e04a34e488bc3fcafde7d3f0287f3f30babb4ea1617231d8/poppy_ai-0.3.1.tar.gz"
  sha256 "243d78dc7f28493226ff8f941f8f0b54e30cbb8ef60ddf0d90c30f263755cda7"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
