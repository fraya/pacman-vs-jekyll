Module: dylan-user

define library pacman-vs-jekyll
  use common-dylan;
  use dylan;
  use dylan-tool;
  use io;
  use system;
  
  export
    pacman-vs-jekyll,
    pacman-vs-jekyll-impl;
end library;

define module pacman-vs-jekyll
  create
    build-website;
end module;

define module pacman-vs-jekyll-impl
  use common-dylan;

  // dylan library
  use threads;
  
  // dylan-tool library
  use pacman;
  
  // io library
  use format;
  use format-out;
  use print;
  use streams;

  // system library
  use file-system;
  use locators;
  
  use pacman-vs-jekyll;

end module;
