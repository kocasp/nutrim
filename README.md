# Nutrin
This template is for render.com free plan
 # How to run
 `bin/dev` in one terminal
 `rails s` in another terminal to enable `binding.pry`
 # Deploy and render setup
 In render.com there are 
 DATABASE_URL
 NUTRIM_DATABASE_PASSWORD
 RAILS_MASTER_KEY
 WEB_CONCURRENCY
 envs set up (NUTRIM_DATABASE_PASSWORD is probably not needed)

 # Databases
 Nutrim data sources are stored in a different repo `nutrim_db`. The only input from the `nutrim_db` to `nutrim` is the `db/db.csv` file placed in this repo.
 For now, each time the db needs to be changed you need to perform `db:drop`, `db:create`, `db:migrate` and `db:seed`.