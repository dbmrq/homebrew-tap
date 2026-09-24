class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/47/d1/f9ba627bb817f724e7b178f1af4129e719c5965299e31f5c4926b820ea35/poppy_ai-0.1.0.tar.gz"
  sha256 "698beb84a5f1992e7c95f224e440cc035cfc9b4c7c5f5808bd33f1783b923475"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
