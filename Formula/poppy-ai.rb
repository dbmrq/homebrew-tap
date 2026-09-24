class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/91/60/ae62e7478d9cd74462fd708af92a909d7b2c5b2a108b996cc0fa8439aa5a/poppy_ai-0.2.0.tar.gz"
  sha256 "009db2595656888386f100e3e67996456f4b99fdc894ee2e8f0d7b5bebdfa110"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
