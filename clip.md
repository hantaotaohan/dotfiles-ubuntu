wget https://download.fastgit.org/gohugoio/hugo/releases/download/v0.79.1/hugo_extended_0.79.1_Linux-64bit.deb -O $HOME/desktop/hugo.deb

cd $HOME/desktop

sudo dpkg -i hugo.deb

cd $HOME

rm -rf $HOME/desktop/hugo.deb

---
hugo theme

$dark: (
  link: $dark-link-color,
  link-hover: $dark-link-hover-color,
  body-color: #FCFCFA,
  hr-color: #595B5C,
  title-color: #FCFCFA,
  subtitle-color: darken(#FCFCFA, 5%),
  border-line-color: rgba(243, 242, 241, 0.1),
  active-font-color: $dark-active-font-color,
  body-background-color: #282c34,
  back-background-color: #282c34,
  navbar-background-color: #282c34,
  navbar-hover-background-color: rgba(225,225,225,0.4),
  navbar-logo-color: $dark-nav-logo-color,
  navbar-menu-color: $dark-nav-menu-color,
  navbar-icon-color: $dark-nav-icon-color,
  search-border-active-color: #282c34,
  search-border-outline-color: rgba(166, 166, 166, 0.45),
  search-background-color: lighten(#282c34, 5%),
  search-placeholder-color: #999,
  search-content-background-color: lighten(#282c34, 5%),
  search-hover-background-color: #24282F,
  search-hover-border-color: #24282F,
  search-border-color: #383838,
  search-highlight-color: #FF6188,
  custom-scrollbar-foreground-color: #888,
  custom-scrollbar-background-color: #eee,
  dropdown-hover-background-color: #727072,
  dropdown-background-color: #595B5C,
  dropdown-item-active-background-color: #424242,
  menu-arrow-color: #FCFCFA,
  pagination-color: #FCFCFA,
  toc-color: #aaa,
  banner-background-color: darken(#282c34, 3%),
  landing-button-primary: $dark-active-font-color,
  landing-button-default: #ccc,
  pagination-link-color: #82aaff,
  pagination-disabled-color: #757575,
  pagination-number-color: #FCFCFA,
  breadcrumb-background-color: #282c34,
  single-hr-background-color: #727072,
  single-blockquote-border-color: #FCFCFA,
  single-contents-title-color: #FCFCFA,
  single-header-title-background-color: #24282F,
  single-contents-subtitle-color: #FCFCFA,
  tag-num-background-color: #595B5C,
  tag-text-background-color: #595B5C,
  content-box-border-color: #616161,
  content-box-background-color: #403E41,
);
