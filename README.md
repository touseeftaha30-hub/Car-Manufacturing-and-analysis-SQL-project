# Car Manufacturing & Sales Analytics — SQL Project

A SQL portfolio project simulating a car manufacturing company's database  covering parts production, supplier sourcing, car assembly, dealer network, and sales, with analytical queries on top.
## Project Overview

This project models an end to end car manufacturing chain:

**Suppliers → Parts (produced + supplied) → Production/Assembly → Vehicles → Dealers → Sales**

The goal was to design a realistic relational schema and then write analytical SQL queries to answer real business questions  sales performance, production output, inventory health, and supplier spend.

**Tools used:** MySQL
## Schema

| Table | Purpose |
|---|---|
| `suppliers` | External companies that supply parts |
| `plants` | Manufacturing locations (assembly / parts / both) |
| `parts` | Individual components (engine, tyre, battery, etc.) |
| `car_models` | Car models and variants |
| `dealers` | Dealer network |
| `part_production` | Parts manufactured in-house, by plant and date |
| `part_supply` | Parts purchased from external suppliers |
| `inventory` | Current stock levels per part, per plant |
| `car_production` | Cars assembled, by model, plant, and batch |
| `car_parts_mapping` | Bill of Materials — which parts (and how many) go into each model |
| `sales` | Car sales to dealers, with revenue |

## Analysis Queries & Insights

1. **Total revenue by car model**  aggregates total revenue generated per model.
2. **Dealer ranking by revenue** (CTE + `RANK()` window function) ranks dealers from best to worst performing by total revenue.
3. **Part-wise production per plant**   total quantity produced, broken down by plant and part.
4. **Best-selling model by dealer**  a 3 table join showing which model each dealer sells the most.
5. **Dealer performance category** (`CASE` statement)  labels dealers as High / Average / Low performer based on revenue thresholds.
6. **Stock status per plant** (`CASE` statement)  flags each part's stock as Good / Normal / Low based on quantity.
7. **Total cost spent per supplier**  multiplies quantity × cost per unit and aggregates by supplier. Also surfaces suppliers with **zero activity** (registered but never used)  a useful real-world signal for reviewing an unused supplier base.
8. **Month-wise sales revenue trend** uses `MONTH()` to compare revenue across January and February.

### Key Insights
 Falcon 1000 has the widest dealer distribution, while Titan SUV sales are concentrated with only two dealers.
 Two of five registered suppliers (Steel Core Industries, PowerCell Batteries) have no recorded purchases  worth reviewing as  inactive vendors.
 No dealer currently falls into the "Low Performer" category, indicating a healthy dealer network overall.
## How to Run

1. Open the `.sql` file in MySQL Workbench (or any MySQL client).
2. Run the full script top to bottom — it creates the database, tables, inserts sample data, and includes all analysis queries at the end.
3. Run each query individually (they're separated by comments) to see results one at a time.


- Category-wise revenue breakdown (Sedan vs SUV vs Hatchback)
- Parts consumption based on car production volume (using the BOM mapping table)
