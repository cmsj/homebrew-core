class AmigaToolchain < Formula
  desc "AmigaOS 3.x cross compiler toolchain (based on GCC 2.95)"
  homepage "https://github.com/cahirwpz/amigaos-cross-toolchain"
  url "https://github.com/cahirwpz/amigaos-cross-toolchain/archive/3b4b739d7b07de858f400495747a2be20047c93a.tar.gz"
  version "0.0.1"
  sha256 "a4bb242c2fe353bf2263d401fb1114053e38ad8ea7a7bbf47d29de8782b99a84"

  head "https://github.com/cahirwpz/amiga-cross-toolchain.git", :branch => "master"

  bottle do
    cellar :any
    sha256 "3b4b739d7b07de858f400495747a2be20047c93a" => :el_capitan
  end

  keg_only "Some gcc commands would clash with Xcode"

  def install
    system "./toolchain-m68k", "--prefix=#{prefix}/m68k-amigaos/", "build"
    system "./toolchain-m68k", "--prefix=#{prefix}/m68k-amigaos/", "install-sdk",
            "ahi", "cgx", "guigfx", "mmu", "mui", "pccard", "render", "sdi", "warp3d"
    prefix.install "examples"
  end

  test do
    cp_r "#{prefix}/examples", testpath
    begin
      e = ENV.to_hash
      p = ENV["PATH"]
      t = ENV["TERM"]
      ENV.clear
      ENV["PATH"] = p
      ENV["TERM"] = t

      ENV.prepend_path "PATH", "#{prefix}/m68k-amigaos/bin"
      system "make", "-C", "examples"
    ensure
      ENV.replace(e)
    end
  end
end
