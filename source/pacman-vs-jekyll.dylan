Module: pacman-vs-jekyll-impl

define thread variable *base-directory* :: <directory-locator>
  = as(<directory-locator>, "./pacman-catalog-website");

define class <template> (<object>)
  constant slot template-name :: <string>,
    required-init-keyword: name:;
  constant slot template-text :: <string>,
    required-init-keyword: text:;
end class;

define class <package-template> (<template>)
  constant slot template-package :: <package>,
    required-init-keyword: package:;
  inherited slot template-text,
    init-value: $template-package;
end;

define method print-object
    (template :: <template>, stream :: <stream>) => ()
  format(stream, template.template-text)
end;

define method print-object
    (template :: <package-template>, stream :: <stream>) => ()
  format(stream,
	 template.template-text,
	 template.template-package.package-name,
	 template.template-package.package-description,
	 template.template-package.package-description)
end;

define method write-template
    (template :: <template>, #key directory = *base-directory*) => ()
  let file = merge-locators(as(<file-locator>, template.template-name),
			    directory);
  with-open-file (stream = file,
		  direction: #"output",
		  if-does-not-exists: #"create")
    format(stream, "%s", template)
  end
end;
  
define function build-website
    (directory :: <directory-locator>, catalog :: <catalog>, #key force?)
 => ()
  *base-directory* := directory;

  // write jekyll's minimal structure
  
  ensure-directories-exist(as(<pathname>, *base-directory*));
  
  let page-404 = make(<template>, name: "404.html", text: $template-404);
  let config = make(<template>, name: "_config.yml", text: $template-config);
  let index = make(<template>, name: "index.md", text: $template-index);
  let gem = make(<template>, name: "Gemfile", text: $template-gemfile);
  let templates = list(page-404, config, index, gem);

  format-out("Writing templates to directory '%s\n", *base-directory*);
  for (template in templates)
    format-out("Writing '%s'\n", template.template-name);   
    write-template(template)
  end;

  // write package collection
  
  let packages-directory = subdirectory-locator(*base-directory*, "_packages");
  ensure-directories-exist(as(<pathname>, packages-directory));
  format-out("Writing packages to '%s'\n", packages-directory);
  
  dynamic-bind (*base-directory* = packages-directory)
    let packages = load-all-catalog-packages(catalog);
    for (package in packages)
      let filename = concatenate(package.package-name, ".md");
      let template = make(<package-template>, name: filename, package: package);
      write-template(template);
    end for;
    format-out("%d packages written\n", packages.size);
  end;
end;
