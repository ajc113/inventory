# README

## Important Data Models

### Location
It's Single Table Inheritance. It has two types - inventory and store. Inventory produces ice-cream and stores sell ice-cream.

### Transfer
This model records transfers from one location to another. Primarily from inventory to store.

### Sale
This model records daily sales of ice-cream for each location and flavor.

### SystemConfiguration
Stores important app related settings. Like which emails will receive the daily report, quantity level that triggers alert emails, etc.

## Development Environment

### Starting the server
The `bin/dev` comman will start the development server at http://localhost:3000.

### Seeding the database
The `bin/rails db:seed` command will populate the database with necessary seed data for the application to run.

### Priming the database

The `bin/rails dev:prime` command will populate the database with test data.

### Reset the development database
The `bin/rails db:complete_reset` task will destroy tables, re-created them, seed and prime the database. Ideal to reset the development environment.
