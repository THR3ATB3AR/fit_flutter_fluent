# Maintainer: THR3ATB3AR <thr3atb3ar at gmail dot com>
pkgname=fit_flutter_fluent
pkgver=1.1.4
pkgrel=1
pkgdesc="FitFlutterFluent - Fluent UI client for FitGirl Repacks and GOG Games"
arch=('x86_64' 'aarch64')
url="https://github.com/THR3ATB3AR/fit_flutter_fluent"
license=('GPL3')
depends=('gtk3' 'libappindicator-gtk3' 'sqlite')
makedepends=('flutter' 'cmake' 'ninja')
source=("$pkgname-$pkgver.tar.gz::https://github.com/THR3ATB3AR/fit_flutter_fluent/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP')

build() {
  cd "$srcdir/$pkgname-$pkgver"
  flutter pub get
  flutter build linux --release
}

package() {
  cd "$srcdir/$pkgname-$pkgver"


  install -d "$pkgdir/usr/share/$pkgname"
  cp -r "build/linux/x64/release/bundle/." "$pkgdir/usr/share/$pkgname/"


  install -d "$pkgdir/usr/bin"
  cat > "$pkgdir/usr/bin/$pkgname" <<EOF

export LD_LIBRARY_PATH="/usr/share/$pkgname/lib"

/usr/share/$pkgname/$pkgname "\$@"
EOF


  chmod +x "$pkgdir/usr/bin/$pkgname"


  install -d "$pkgdir/usr/share/applications"
  cat > "$pkgdir/usr/share/applications/$pkgname.desktop" <<EOF
[Desktop Entry]
Name=FitFlutterFluent
Comment=Fluent UI client for FitGirl Repacks and GOG Games
Exec=$pkgname
Icon=$pkgname
Terminal=false
Type=Application
Categories=Game;Utility;
StartupWMClass=fit_flutter_fluent
EOF

  install -d "$pkgdir/usr/share/icons/hicolor/256x256/apps"
  install -m644 "assets/icon.png" "$pkgdir/usr/share/icons/hicolor/256x256/apps/$pkgname.png"
}
