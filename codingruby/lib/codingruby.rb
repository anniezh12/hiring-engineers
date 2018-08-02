require "codingruby/version"
require 'rubygems'
require 'dogapi'
module Codingruby

  api_key = "476d1be45bf39e3c37d842cb5449cc2b"
  app_key = "24d5357e506a01822cc445fad4a23e693ab0fa24"

  dog = Dogapi::Client.new(api_key, app_key)

  # Create a timeboard.

  title = 'My Metrics'

  description = 'And they are marvelous.'

  graphs = [{
            "definition" => {
          "events" => [],
          "requests" => [{
              "q" => "avg:system.mem.free{*}"
          }],
          "viz" => "timeseries"
      },"title" => "Average Memory Free "},

  {

    "definition" => {
        "events" => [],
        "requests" => [{"q" => "avg:system.mem.free{*}" }],
        "viz" => "heatmap"
    },
    "title" => "Average Memory Free In heatmap"},

    {
      "definition" => {
          "events" => [],
          "requests" => [{"q" => "my_metric{*} by {host}" }],
          "viz" => "timeseries"
      },
      "title" => "My custom Metric my_metric"},

      {
        "definition" => {
            "events" => [],
            "requests" => [{"q" => "anomalies(avg:mysql.performance.cpu_time{host:aniqa}, 'basic', 1)" }],
            "viz" => "timeseries"
        },
        "title" => "Database Metric with an anomaly function "},
       {
          "definition" => {
              "events" => [],
              "requests" => [{"q" => "anomalies(avg:mysql.performance.open_files{host:aniqa}, 'basic', 1)" }],
              "viz" => "timeseries"
          },
          "title" => "Database Metric with an anomaly function  using open_files"},

      {
        "definition" => {
            "events" => [],
            "requests" => [{ "q" => "avg:my_metric{host:aniqa}.rollup(avg,120)" }],
            "viz" => "timeseries"
        },
        "title" => "Rollup function applied to  sum of my_metric"

}]
  template_variables = [{
      "name" => "host1",
      "prefix" => "host",
      "default" => "host:my-host"
  }]

  dog.create_dashboard(title, description, graphs, template_variables)

end
