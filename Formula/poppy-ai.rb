class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/6e/73/b76bb27ea015dc9e8b7c245c55833664e5e5afacfa735dd0e4cf3a55e82c/poppy_ai-0.3.0.tar.gz"
  sha256 "6ae82252949ea39a8f31e579ae5c3412f2366c9ce028ac675c8c7147155cfd4c"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
