class PolytaxisUnwrap < Formula
  desc "polytaxis-unwrap"
  homepage "https://github.com/Rendaw/polytaxis-unwrap/"
  head "https://github.com/Rendaw/polytaxis-unwrap.git", :using => :git

  depends_on "gcc5" if OS.mac?
  depends_on :osxfuse if OS.mac?
  depends_on "tup" if OS.mac?

  def install
    system "tup", "init"
    system "cp", "tup.template.config", "tup.config"
    inreplace "tup.config" do |s|
      s.gsub! /^CONFIG_COMPILERBIN=.*$/, "CONFIG_COMPILERBIN=g++-5"
      s.gsub! /^CONFIG_CCOMPILERBIN=.*$/, "CONFIG_CCOMPILERBIN=gcc-5"
      s.gsub! /^CONFIG_LINKERBIN=.*$/, "CONFIG_LINKERBIN=g++-5"
      s.gsub! /^CONFIG_BUILDFLAGS=.*$/, "CONFIG_BUILDFLAGS=-I/usr/local/include/osxfuse/ -I/usr/local/include/osxfuse/fuse/"
      s.gsub! /^CONFIG_LINKFLAGS=.*$/, "CONFIG_LINKFLAGS=-L/usr/local/lib -losxfuse -liconv"
    end if OS.mac?
    system "tup", "upd"
    bin.install "polytaxis-unwrap"
  end
end
