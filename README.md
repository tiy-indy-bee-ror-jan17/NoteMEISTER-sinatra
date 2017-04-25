# NoteMEISTER 5000

Skeleton app for the tubular NoteMEISTER 5000 API on Sinatra.

Run `rake test` to run the tests.

And `bundle` to install the basic dependencies.


Path: Backend Engineering (Ruby on Rails) - January 2017  Unit: Week 4 - Enter the Web
NoteMEISTER 5000 needs an API. And Sinatra knows that ditty.

Description

Hi. I'm Jacques, a frontend developer working with you on the Notemeister 5000 application.


I have the frontend all laid to use your API. Here's what I'm expecting (note, these values are examples, they should be the values of the actual note):

```

GET /api/notes

[
  {
    "title" : "My awesome post",
    "body" : "My awesome body of a post",
    "tags" : [
      { "name" : "awesome" },
      { "name" : "funny" },
      { "name" : "spiffy" }
    ]
  },
  {
    "title" : "My awesome second post",
    "body" : "My awesome body of a second post",
    "tags" : [
      { "name" : "not_so_awesome" },
      { "name" : "not_funny" },
      { "name" : "not_at_all_spiffy" }
    ]
  }
]
POST /api/notes -d {"title" : "My created post", "body" : "My created body", "tags" : "api, machine, first"}

{
  "title" : "My created post",
  "body" : "My created body",
  "tags" : [
    { "name" : "api" },
    { "name" : "machine" },
    { "name" : "first" }
  ]
}

```
If I try to create a note without a title or body, I should get back a JSON-formatted error message and a status code of 400

```
GET /api/notes/tag/funny

{
  "name" : "funny",
  "notes" : [
    {
      "title" : "My awesome post",
      "body" : "My awesome body of a post",
      "tags" : [
        { "name" : "awesome" },
        { "name" : "funny" },
        { "name" : "spiffy" }
      ]
    },
    {
      "title" : "My awesome second post",
      "body" : "My awesome body of a second post",
      "tags" : [
        { "name" : "not_so_awesome" },
        { "name" : "funny" },
        { "name" : "not_at_all_spiffy" }
      ]
    }
  ]
}
```
Deliverables

A fork of the the skeleton app in the organization account
A PR from the fork to the org repo with all the tests passing.
A link to your forked repo submitted to TIYO.
Requirements

Explorer Mode

Help Jacques out and create the API he needs using Sinatra and ActiveRecord.
You'll know you have this complete when rake test is green.

Adventure Mode

Use RABL to generate your API responses via templates.
In a CLI folder, write a ruby script that can be used to post and read notes from your API from the command line. Use HTTParty for the HTTP requests.
Your CLI should have classes representing each of the objects you get back from the API.

Epic Mode

Notes should have comments. They should be included in the API response for notes#show but have their own create actions/endpoints
Add your own tests for said endpoints and adjust the tests for your changed API responses
