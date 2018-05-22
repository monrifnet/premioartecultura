## Basic usage

* Add content by running `hugo new page/{$YEAR}/{$PAGE_NAME}.md`, correct date and title in frontmatter if necessary;
* Edit single content date to correctly annotate it as archive and generate menus (see 2015 example);
* Edit main config.toml to add to archive menu, change default metas.

## Development

* Install theme `cd themes && git clone {$THEME_REPO}`, modify main config.toml accordingly; 
* Run server for development (includes build in /public) with livereload: `hugo server --watch -D --verbose`;
* Check http://localhost:1313/sitemap.xml for all generated patterns;
## Deploy on s3

## TODO

* Cloudfront distribution, to be integrated in setup and deploy scripts
