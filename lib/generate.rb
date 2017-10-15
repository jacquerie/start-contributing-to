#!/usr/bin/env ruby

require "octokit"
require "yaml"


def crawl client, org_name
  repos = client.org_repos org_name
  response = client.search_issues "org:\"#{org_name}\" label:\"help wanted\" state:\"open\""
  issues = response[:items]

  url_map = {}
  repos.each do |repo|
    url = repo[:url]
    url_map[url] = repo
  end

  issues.each do |issue|
    url = issue[:repository_url]
    issue[:full_name] = url_map[url][:full_name]
    issue[:language] = url_map[url][:language]
  end

  language_map = Hash.new { |language_map, language| language_map[language] = []}
  issues.each do |issue|
    language = issue[:language]
    language_map[language].push({
      "title" => issue[:title],
      "labels" => issue[:labels].map { |label| label[:name] },
      "body" => issue[:body],
      "html_url" => issue[:html_url],
      "full_name" => issue[:full_name],
      "number" => issue[:number],
      "created_at" => issue[:created_at],
      "updated_at" => issue[:updated_at],
      "comments" => issue[:comments],
    })
  end

  result = language_map.map do |language, issues|
    {"name" => language.nil? ? "None" : language, "issues" => issues}
  end.sort_by { |el| el["name"] }

  result 
end


Octokit.auto_paginate = true
client = Octokit::Client.new :netrc => true

org_name = ARGV[0]
result = crawl client, org_name

File.write("_data/org.yaml", {"name" => org_name}.to_yaml)
File.write("_data/issues.yaml", result.to_yaml)
