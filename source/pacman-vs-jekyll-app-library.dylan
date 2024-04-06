Module: dylan-user
Synopsis: Pacman-vs-jekyll application library

define library pacman-vs-jekyll-app
  use common-dylan;  
  use command-line-parser;
  use dylan-tool;
  use io;
  use system;
  
  use pacman-vs-jekyll;
end library;

define module pacman-vs-jekyll-app
  use common-dylan;

  // command-line-parser library
  use command-line-parser;

  // dylan-tool library
  use pacman;
  
  // io library
  use format;
  use format-out;
  use print;
  use standard-io;

  // system library
  use locators;

  use pacman-vs-jekyll;
end module;
