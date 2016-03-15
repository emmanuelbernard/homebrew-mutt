# Note: Mutt has a large number of non-upstream patches available for
# it, some of which conflict with each other. These patches are also
# not kept up-to-date when new versions of mutt (occasionally) come
# out.
#
# To reduce Homebrew's maintenance burden, new patches are not being
# accepted for this formula. We would be very happy to see members of
# the mutt community maintain a more comprehesive tap with better
# support for patches.

class Mutt < Formula
  desc "Mongrel of mail user agents (part elm, pine, mush, mh, etc.)"
  homepage 'http://www.mutt.org/'
  url 'https://mirrors.kernel.org/debian/pool/main/m/mutt/mutt_1.5.24.orig.tar.gz'
  mirror 'https://mirrors.ocf.berkeley.edu/debian/pool/main/m/mutt/mutt_1.5.24.orig.tar.gz'
  sha256 "a292ca765ed7b19db4ac495938a3ef808a16193b7d623d65562bb8feb2b42200"

  bottle do
    revision 3
    sha256 "7dcb549c1a9efc7f4c1a0602709478cae6f071215a762c77b4d9fba1ab561287" => :yosemite
    sha256 "4b9b8c3a3b069d6103f650f1136161d41de1bc6014a682b6c15fd8d562cc773b" => :mavericks
    sha256 "79b84411d1f0916e7df520b9fbac9f9d4479a4631f5da6b616f363fd6f68d0c2" => :mountain_lion
  end

  head do
    url 'http://dev.mutt.org/hg/mutt#default', :using => :hg

    resource 'html' do
      url 'http://dev.mutt.org/doc/manual.html', :using => :nounzip
    end
  end

  unless Tab.for_name('signing-party').with? 'rename-pgpring'
    conflicts_with 'signing-party',
      :because => 'mutt installs a private copy of pgpring'
  end

  conflicts_with 'tin',
    :because => 'both install mmdf.5 and mbox.5 man pages'

  option "with-debug", "Build with debug option enabled"
  option "with-trash-patch", "Apply trash folder patch"
  option "with-sidebar-patch", "Apply sidebar patch"
  option "with-indexcolor-patch", "Apply indexcolor patch"
  option "with-s-lang", "Build against slang instead of ncurses"
  option "with-ignore-thread-patch", "Apply ignore-thread patch"
  option "with-pgp-verbose-mime-patch", "Apply PGP verbose mime patch"
  option "with-confirm-attachment-patch", "Apply confirm attachment patch"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on 'openssl'
  depends_on 'tokyo-cabinet'
  depends_on 's-lang' => :optional
  depends_on 'gpgme' => :optional

  patch do
    url "http://ftp.fr.openbsd.org/pub/OpenBSD/distfiles/mutt/trashfolder-1.5.24.diff.gz"
    sha256 "395ffaa6517306e5f5e7327a1aacf3a5cadb34c5b6483170e3f314c95fdb5cb7"
  end if build.with? "trash-patch"

  patch do
    url "http://ftp.fr.openbsd.org/pub/OpenBSD/distfiles/mutt/sidebar-1.5.24.diff.gz"
    sha256 "75f208279ad2a6fe7066dee97ef6fa56a9f0e663c2d94bcb069cda91bd7a4ccf"
  end if build.with? "sidebar-patch"

  if build.with? "indexcolor-patch"
    patch do
      url "https://blog.x-way.org/stuff/mutt-1.5.24-indexcolor.diff"
      sha256 "96c3ab28e0cb03646fbb0357650628591efabb102596978d1b05960d0e511f33"
    end
  end

  # original source for this went missing, patch sourced from Arch at
  # https://aur.archlinux.org/packages/mutt-ignore-thread/
  patch do
    url "https://gist.githubusercontent.com/mistydemeo/5522742/raw/1439cc157ab673dc8061784829eea267cd736624/ignore-thread-1.5.21.patch"
    sha1 "dbcf5de46a559bca425028a18da0a63d34f722d3"
  end if build.with? "ignore-thread-patch"

  patch do
    url "http://patch-tracker.debian.org/patch/series/dl/mutt/1.5.21-6.2+deb7u1/features-old/patch-1.5.4.vk.pgp_verbose_mime"
    sha1 "a436f967aa46663cfc9b8933a6499ca165ec0a21"
  end if build.with? "pgp-verbose-mime-patch"

  patch do
    url "https://gist.githubusercontent.com/tlvince/5741641/raw/c926ca307dc97727c2bd88a84dcb0d7ac3bb4bf5/mutt-attach.patch"
    sha1 "94da52d50508d8951aa78ca4b073023414866be1"
  end if build.with? "confirm-attachment-patch"


  def install
    args = ["--disable-dependency-tracking",
            "--disable-warnings",
            "--prefix=#{prefix}",
            "--with-ssl=#{Formula['openssl'].opt_prefix}",
            "--with-sasl",
            "--with-gss",
            "--enable-imap",
            "--enable-smtp",
            "--enable-pop",
            "--enable-hcache",
            "--with-tokyocabinet",
            # This is just a trick to keep 'make install' from trying to chgrp
            # the mutt_dotlock file (which we can't do if we're running as an
            # unpriviledged user)
            "--with-homespool=.mbox"]
    args << "--with-slang" if build.with? 's-lang'
    args << "--enable-gpgme" if build.with? 'gpgme'

    if build.with? 'debug'
      args << "--enable-debug"
    else
      args << "--disable-debug"
    end


    system "./prepare", *args
    system "make"
    system "make", "install"

    doc.install resource("html") if build.head?
  end

  test do
    system bin/"mutt", "-D"
  end
end
