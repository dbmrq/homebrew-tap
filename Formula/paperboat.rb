# typed: false
# frozen_string_literal: true

class Paperboat < Formula
  desc "AI agents can be used to accomplish nearly anything"
  homepage "https://github.com/dbmrq/paperboat"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.1/paperboat_0.1.1_Darwin_x86_64.tar.gz"
      sha256 "81fd5f4379a47474b7119a9d17d608e12ebf3020884be22f9901528c27cc3a0a"

      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.1/paperboat_0.1.1_Darwin_arm64.tar.gz"
      sha256 "1d4e882462dd9d6a5811b63178bbfa6c0f36012d2dee621c09c71b5058189398"

      def install
        bin.install "paperboat"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.1/paperboat_0.1.1_Linux_x86_64.tar.gz"
      sha256 "17b0d49d6adf9eee6fa9ff9ed8d441d44c07c5b23f736e89b11e7a83b89af29d"
      def install
        bin.install "paperboat"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/dbmrq/paperboat/releases/download/v0.1.1/paperboat_0.1.1_Linux_arm64.tar.gz"
      sha256 "ba13e646a884995203a7dad9a984defad2a5c91511ffcefb4da374097f72e13e"
      def install
        bin.install "paperboat"
      end
    end
  end

  test do
    system "#{bin}/paperboat", "--help"
  end
end
