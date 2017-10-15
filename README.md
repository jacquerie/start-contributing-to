# start-contributing-to #

Make contributing to your organization's open source projects easier by
collecting and categorizing all issues in one place!

This project is made of two parts:

1. a ruby script that consumes GitHub's API and collects data,
2. a static website generator that uses this data to build a searchable
   overview over your issues.

Both parts were made using GitHub's own libraries, respectively Octokit
and Jekyll. In fact, we suggest using `start-contributing-to` to generate
your organization's main page on `github.io`. For more information, see
GitHub's excellent documentation: https://pages.github.com/.

## Install ##

```shell
$ bundle install
```

## Usage ##

Create a `.netrc` file in your home directory containing
```yaml
machine api.github.com
  login $YOUR_GITHUB_USER_NAME
  password $YOUR_GITHUB_USER_PASS
```
Then you can start developing by doing
```shell
$ lib/generate.rb $YOUR_ORG_NAME
$ bundle exec jekyll serve
```
and pointing your browser to `localhost:4000`.

## Author ##

Jacopo Notarstefano ([@Jaconotar](https://twitter.com/Jaconotar))

## License ##

MIT
