Module: pacman-vs-jekyll-app

define constant $app-help
  = "%s creates a Jekyll website from Opendylan's package catatalog.";

define command-line <app-command-line> ()
  option app-directory :: <string>,
    names: #("output", "o"),
    kind: <parameter-option>,
    default: "pacman-catalog-website",
    help: "Output directory (Default: %default%)";
end command-line;

define function app-command-line
    (app-name :: <string>, arguments :: <vector>)
 => (cmd :: <app-command-line>)
  let app-help     = format-to-string($app-help, app-name);
  let command-line = make(<app-command-line>, help: app-help);
  
  parse-command-line(command-line, arguments);
  command-line
end;

define function main
    (name :: <string>, arguments :: <vector>)
  block ()
    let command-line   = app-command-line(name, arguments);
    let base-directory = as(<directory-locator>, command-line.app-directory);
    let pacman-catalog = catalog();
    
    build-website(base-directory, pacman-catalog);
    exit-application(0);
  exception (err :: <error>)
    format-err("Error: %s\n", err);
    exit-application(1);
  end block;  
end function;

main(application-name(), application-arguments());
