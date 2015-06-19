class PolytaxisUnwrap < Formula
  desc "polytaxis-unwrap"
  homepage "https://github.com/Rendaw/polytaxis-unwrap/"
  head "https://github.com/Rendaw/polytaxis-unwrap.git", :using => :git

  depends_on :osxfuse
  depends_on "tup"

  def install
    system "tup", "init"
    system "cp", "tup.template.config", "tup.config"
    system "tup", "upd"
    bin.install "polytaxis-unwrap"
  end
end
