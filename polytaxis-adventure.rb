$pypi_tuples = [
  ["appdirs", "1.4.0", "8fc245efb4387a4e3e0ac8ebcc704582df7d72ff6a42a53f5600bbb18fdaadc5"],
  ["argh", "0.26.1", "06a7442cb9130fb8806fe336000fcf20edf1f2f8ad205e7b62cec118505510db"],
  ["natsort", "4.0.1", "48fde822e66a7f08de8ecf29367f4007c625f6d6260c9ce17f41d0f0c6aac687"],
  ["pathtools", "0.1.2", "7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0"],
  ["patricia-trie", "10", "65a35219bf211b4e4b34bdd9e858c008e1699e23c43b3fb4542726c996966bae"],
  ["PyYAML", "3.11", "c36c938a872e5ff494938b33b14aaa156cb439ec67548fcab3535bb78b0846e8"],
]

class PolytaxisAdventure < Formula
  desc "polytaxis-adventure"
  homepage "https://github.com/Rendaw/ptadventure/"
  head "https://github.com/Rendaw/ptadventure.git", :using => :git

  depends_on :python3
  depends_on "pyqt5" if OS.mac?

  $pypi_tuples.each do |tuple|
    resource tuple[0] do
      url "https://pypi.python.org/packages/source/#{tuple[0][0,1]}/#{tuple[0]}/#{tuple[0]}-#{tuple[1]}.tar.gz"
      sha256 tuple[2]
    end
  end

  resource "polytaxis-python" do
    url "https://github.com/Rendaw/polytaxis-python/archive/master.zip"
    sha256 "f736ade482a56833182549ab2b153178b3a4e65e48837da60781bc8b5a130720"
  end
  
  resource "polytaxis-monitor" do
    url "https://github.com/Rendaw/polytaxis-monitor/archive/master.zip"
    sha256 "5c01c50adcf785f72ee7ffb24a05163054e7c0ef5305cd8b2e7aa1d6c09b35ea"
  end

  def install
    # Homebrew sets an incorrect default PYTHONPATH in env for some reason
    ENV["PYTHONPATH"] = "/usr/local/lib/python3.4/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python3.4/site-packages"
    def install_pip(r)
      resource(r).stage do
        system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end
    $pypi_tuples.each do |r| install_pip r[0] end
    install_pip "polytaxis-python"
    install_pip "polytaxis-monitor"

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.4/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
