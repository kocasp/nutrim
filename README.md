# Nutrin  

This template is designed for the free plan on Render.com.  

## How to Run  
1. Start `bin/dev` in one terminal.  
2. Run `rails s` in another terminal to enable `binding.pry`.  

## Deployment and Render Setup  
The following environment variables are configured on Render.com:  
- `DATABASE_URL`  
- `NUTRIM_DATABASE_PASSWORD` (likely unnecessary)  
- `RAILS_MASTER_KEY`  
- `WEB_CONCURRENCY`  

## Databases  
Nutrim relies on external data sources stored in a separate repository: `nutrim_db`. The only required input from `nutrim_db` is the `db/db.csv` file, which should be placed in this repository.  

Currently, updating the database requires the following steps:  
1. `db:drop`  
2. `db:create`  
3. `db:migrate`  
4. `db:seed`  
