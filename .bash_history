clear
ls -la
git init
git add .
git commit -m ":tada: first commit"
mix phx.gen.html User Professor name:string title:string
mix phx.gen.html User Teacher teachers name:string title:string
mix phx.gen.html User Student students name:string registration:integer
mix phx.gen.html Class Class classes code:string room:string open_date:utc_datetime close_date:utc_datetime teacher:references:teachers
mix phx.gen.html School Class classes code:string room:string open_date:utc_datetime close_date:utc_datetime teacher:references:teachers
mix ecto.migrate
mix local.hex
mix ecto.migrate
ls -la
mix ecto.create
mix local.hex
mix ecto.create
mix local.hex
mic ecto.create
mix ecto.create
