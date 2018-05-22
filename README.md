## Basic usage

* Install theme `cd themes && git clone {$THEME_REPO}`, modify main config.toml accordingly; 
* Run server for development (includes build in /public) with livereload: `hugo server --watch -D --verbose`;
* Check http://localhost:1313/sitemap.xml for all generated patterns;
* Add intro: `hugo new intro/{$YEAR}.md`;
* Add winner page `hugo new winner/{$YEAR}.md`;
* Edit single content date to correctly annotate it as archive and generate menus (see 2015 example);
* Edit main config.toml to add to archive menu, change default metas.
