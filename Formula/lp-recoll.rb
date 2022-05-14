require 'formula'

# Notes:
# - This formula is missing python-libxml2 and python-libxslt deps
#   which recoll needs for indexing many formats (e.g. libreoffice,
#   openxml). Homebrew does not include these packages.
#   So the user needs to install them with pip because I don't understand how
#   the "Resource" homebrew thing works.
# Still a bit of work then, but I did not investigate, because the macports
# version was an easier target.

class Recoll < Formula
  desc "Desktop search tool"
  homepage 'http://www.recoll.org'
  url 'http://www.recoll.org/recoll-1.29.2.tar.gz'
  sha256 "f0dde51cb01ed710ee70170bbdb95e535fced4b9de441e38827ba32d17aaf182"

  depends_on "xapian"
  depends_on "antiword"
  depends_on "poppler"
  depends_on "unrtf"

  def install
    # homebrew has webengine, not webkit and we're not ready for this yet
    system "./configure",
           "--disable-qtgui",
           "--disable-python-module",
           "--enable-recollq",
           "--prefix=#{prefix}"
    system "make", "install"
    # bin.install "#{buildpath}/qtgui/recoll.app/Contents/MacOS/recoll"
  end

  test do
    system "#{bin}/recollindex", "-h"
  end
end
