use superstoresdb;

#customer table
#Primary Key: Cust_Id
#Foreign Key: No FK

#products table
#Primary Key: Prod_Id
#Foreign Key: No FK 

#orders table
#Primary Key: Ord_id
#Foreign Key: No FK

#shipment table
#Primary Key: Ship_id
#Foreign Key: No FK

#CheckPoint 2      
#Find the total and average sales
describe market_fact;
select sum(sales) from market_fact;
select avg(sales) from market_fact;

#Display the number of customers in each region in decreasing order of no_of_customers. 
#The result should be a table with columns Region, no_of_customers
select Region, count(*) as no_of_customers 
      from customer
      group by Region
      order by no_of_customers desc;

#Find the region having maximum customers (display the region name and max(no_of_customers)
select Region, count(*) as no_of_customers from customer group by Region order by no_of_customers DESC limit 1;

#Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 
select Prod_id, sum(Order_Quantity) as no_of_products_sold
      from sales
      group by Prod_id
      order by no_of_products_sold desc;

#Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)
select Customer_Name, sum(Order_Quantity) as num_tables
      from market_fact s, customer c, products p
      where s.Cust_id = c.Cust_id and
      s.Prod_id = p.Prod_id and 
      p.Product_Sub_Category = 'TABLES' and
      c.Region = 'ATLANTIC'
      group by Customer_Name;

#CheckPoint 3      
#Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
select Product_Category, sum(profit) as total_profit
      from market_fact s, products p
      where s.Prod_id = p.Prod_id
      group by p.Product_Category
      order by total_profit DESC;

#Display the product category, product sub-category and the profit within each sub-category in three columns.
select Product_Category, Product_Sub_Category, sum(profit) as total_profit
      from market_fact s, products p
      where s.Prod_id = p.Prod_id
      group by Product_Category,Product_Sub_Category
      order by total_profit;

#Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, 
# display the  region-wise no_of_shipments and the profit made in each region in decreasing order of profits 
# (i.e. region, no_of_shipments, profit_in_each_region)
select Region, count(*) as no_of_table_shipments, sum(profit) as profit_in_region
      from market_fact s, customer c, products p
      where s.Cust_id = c.Cust_id and
      s.Prod_id = p.Prod_id and
      p.Product_Sub_Category = 'TABLES'
      group by Region
      order by profit_in_region desc;
