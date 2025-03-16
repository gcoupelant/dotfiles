# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep \
    openssh \
    screen \
    php \
    gmp

# GNU replacements
brew install findutils \
    gnu-indent \
    gnu-sed \
    gnutls \
    grep \
    gnu-tar \
    gawk
