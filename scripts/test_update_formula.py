import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import update_formula  # noqa: E402

OLD_SHA = "0" * 64
NEW_SHA = "f" * 64
FORMULA = f'''class PoppyAi < Formula
  include Language::Python::Virtualenv

  url "https://files.pythonhosted.org/packages/aa/bb/cc/poppy_ai-0.1.0.tar.gz"
  sha256 "{OLD_SHA}"
  license "MIT"
end
'''
PYPI = {
    "info": {"version": "0.2.0"},
    "urls": [
        {
            "packagetype": "sdist",
            "filename": "poppy_ai-0.2.0.tar.gz",
            "url": "https://files.pythonhosted.org/packages/dd/ee/ff/poppy_ai-0.2.0.tar.gz",
            "digests": {"sha256": NEW_SHA},
        }
    ],
}


class TestUpdateFormula(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.path = Path(self.tmp.name) / "poppy-ai.rb"
        self.path.write_text(FORMULA, encoding="utf-8")

    def tearDown(self):
        self.tmp.cleanup()

    def test_updates_url_and_sha(self):
        changed, old, new = update_formula.update_formula(self.path, "poppy-ai", PYPI)
        self.assertTrue(changed)
        self.assertEqual((old, new), ("0.1.0", "0.2.0"))
        text = self.path.read_text(encoding="utf-8")
        self.assertIn("poppy_ai-0.2.0.tar.gz", text)
        self.assertIn(NEW_SHA, text)
        self.assertNotIn(OLD_SHA, text)
        # unrelated lines are untouched
        self.assertIn('license "MIT"', text)
        self.assertIn("Language::Python::Virtualenv", text)

    def test_noop_when_current(self):
        update_formula.update_formula(self.path, "poppy-ai", PYPI)
        before = self.path.read_text(encoding="utf-8")
        changed, _old, new = update_formula.update_formula(self.path, "poppy-ai", PYPI)
        self.assertFalse(changed)
        self.assertEqual(new, "0.2.0")
        self.assertEqual(self.path.read_text(encoding="utf-8"), before)

    def test_refuses_non_pypi_url(self):
        self.path.write_text(
            'class PoppyAi < Formula\n  url "https://example.com/poppy_ai-0.1.0.tar.gz"\n'
            f'  sha256 "{OLD_SHA}"\nend\n',
            encoding="utf-8",
        )
        with self.assertRaises(SystemExit):
            update_formula.update_formula(self.path, "poppy-ai", PYPI)

    def test_requires_url_and_sha(self):
        self.path.write_text("class PoppyAi < Formula\nend\n", encoding="utf-8")
        with self.assertRaises(SystemExit):
            update_formula.update_formula(self.path, "poppy-ai", PYPI)


if __name__ == "__main__":
    unittest.main()
