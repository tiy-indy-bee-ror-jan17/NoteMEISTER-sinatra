# NoteMEISTER 5000

Skeleton app for the tubular NoteMEISTER 5000 API on Sinatra.

Run `rake test` to run the tests.

And `bundle` to install the basic dependencies.


Explorer Mode
- Help Jacques out and create the API he needs using Sinatra and ActiveRecord.
- You'll know you have this complete when rake test is green.

Adventure Mode
- Use RABL to generate your API responses via templates.
- In a CLI folder, write a ruby script that can be used to post and read notes from your API from the command line. Use HTTParty for the HTTP requests.
- Your CLI should have classes representing each of the objects you get back from the API.

Epic Mode
- Notes should have comments. They should be included in the API response for notes#show but have their own create actions/endpoints
- Add your own tests for said endpoints and adjust the tests for your changed API responses
