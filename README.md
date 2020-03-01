# Githubstats

Welcome to Gitstats. We need to go through the following ground work before we can git stats on people's Github!
To start the Phoenix server:

  * Create `.env` and copy the variables from `config/localhost.env`. Make sure to replace `GITHUB_API_KEY` with valid API key in `.env` file only.
  ```
  cp config/localhost.env .env
  ```
  * Run the local start script which takes care of installing dependencies and starting the server for you!
  ```
  ./bin/local_start.sh
  ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
