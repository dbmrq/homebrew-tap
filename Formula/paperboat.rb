# typed: false
# frozen_string_literal: true

class Paperboat < Formula
  desc "AI agents can be used to accomplish nearly anything"
  homepage "https://github.com/dbmrq/paperboat"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.0/paperboat_0.1.0_Darwin_x86_64.tar.gz"
      sha256 "3793cbdadbe0dcff6cd180a249fc0d7ec46563a73dfd8c10a0cc978f24bd00cc"

      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.0/paperboat_0.1.0_Darwin_arm64.tar.gz"
      sha256 "71c48fa7fee7e8d8f1c29bbf330c1a8c81c5d87d76163a944aeb6f41e889932d"

      def install
        bin.install "paperboat"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.0/paperboat_0.1.0_Linux_x86_64.tar.gz"
      sha256 "9b3f070a3282f54fdd89c94ed3e9d9ef81550ff11ae82785b26125996af7769b"
      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.0/paperboat_0.1.0_Linux_arm64.tar.gz"
      sha256 "8aa07c7f5ae9bb69aec68cf47ab220389a7ca394f2ee717746016f47f186a615"
      def install
        bin.install "paperboat"
      end
    end
  end

  test do
    system "#{bin}/paperboat", "--help"
  end
end
