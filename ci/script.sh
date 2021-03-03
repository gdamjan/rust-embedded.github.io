set -euxo pipefail

main() {
    # release from which we extract CSS and fonts
    local tag=1.29.0

    rm -rf doc

    mkdir doc

    # CSS and fonts and their licenses
    pushd doc
    curl -LO https://github.com/rust-lang/rust/raw/$tag/src/doc/rust.css
    local static=https://github.com/rust-lang/rust/raw/$tag/src/librustdoc/html/static
    curl -LO $static/FiraSans-Regular.woff
    curl -LO $static/FiraSans-Medium.woff
    curl -LO $static/FiraSans-LICENSE.txt
    curl -LO $static/Heuristica-Italic.woff
    curl -LO $static/Heuristica-LICENSE.txt
    curl -LO $static/SourceSerifPro-Regular.woff
    curl -LO $static/SourceSerifPro-Bold.woff
    curl -LO $static/SourceSerifPro-LICENSE.txt
    curl -LO $static/SourceCodePro-Regular.woff
    curl -LO $static/SourceCodePro-Semibold.woff
    curl -LO $static/SourceCodePro-LICENSE.txt
    curl -LO $static/LICENSE-MIT.txt
    curl -LO $static/LICENSE-APACHE.txt
    curl -LO $static/COPYRIGHT.txt
    popd

    # build index page
    rustdoc --markdown-css rust.css --markdown-no-toc index.md
    rustdoc --markdown-css rust.css faq.md

    # check links
    # FIXME(rust-lang-nursery/mdbook#789) remove `--ignore-url` when that bug is fixed
    linkchecker --ignore-url "print.html" doc
}

main
