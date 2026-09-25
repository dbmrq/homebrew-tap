class PoppyAi < Formula
  include Language::Python::Virtualenv

  desc "Turn coding-agent session history into reviewed skills, memories, and rules"
  homepage "https://github.com/dbmrq/poppy"
  url "https://files.pythonhosted.org/packages/60/aa/6f955a60b0df9852241c96df6165b6f73ab9362b64a5f33dfd2262c2c1d1/poppy_ai-0.5.1.tar.gz"
  sha256 "398e86e4880aaaba9afe8723f8df222aad08c38d87558dc029ca1b9cb2160f34"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "poppy", shell_output("#{bin}/poppy --version")
  end
end
