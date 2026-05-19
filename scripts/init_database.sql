/*
===========================================================
Create Database and Schemas
===========================================================
Script Purpose:
  This script initializes the local DataWarehouse database for development and learning purposes.
  It optionally drops the existing DataWarehouse database, recreates it, and sets up the basic
  schema structure for the Bronze, Silver, and Gold layers.

WARNING:
  This script resets the demo database.
  It drops the existing DataWarehouse database if it exists.
  Use only in a local development.
  Do not run in production.
*/

USE master;
GO

-- Optional reset step for local development only.
-- Comment this block out if you do not want to delete the existing database.
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
Create DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
