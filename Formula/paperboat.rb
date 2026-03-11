# typed: false
# frozen_string_literal: true

class Paperboat < Formula
  desc "AI agents can be used to accomplish nearly anything"
  homepage "https://github.com/dbmrq/paperboat"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.2.0/paperboat_0.2.0_Darwin_x86_64.tar.gz"
      sha256 "dd7267b693b7f27a2efba30d0df8d14b7134a646ae6be9fa57abdaab01ecbee7"

      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.2.0/paperboat_0.2.0_Darwin_arm64.tar.gz"
      sha256 "61a0df2edea9d691916255485455b698aaa91aff71182bb38bd914d4e84cb20b"

      def install
        bin.install "paperboat"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.2.0/paperboat_0.2.0_Linux_x86_64.tar.gz"
      sha256 "b7f5e5e56637e98abcbf06b930a0acdd2dc0819239400b924aad24fa9f996d0f"
      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.2.0/paperboat_0.2.0_Linux_arm64.tar.gz"
      sha256 "b4966f0e118c1443084204780e071478fab70fa319c5322ee954e98f63ad2edf"
      def install
        bin.install "paperboat"
      end
    end
  end

  test do
    system "#{bin}/paperboat", "--help"
  end
end
