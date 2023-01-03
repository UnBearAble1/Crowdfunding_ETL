-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT c.backers_count,
c.cf_id
INTO live_backers
FROM campaign AS c
WHERE (c.outcome = 'live')
ORDER BY (c.backers_count) DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT (b.cf_id), b.cf_id
INTO backers_check
FROM backers AS b
GROUP BY b.cf_id
ORDER BY COUNT (b.cf_id) DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

-- update campaign table with new column for remaining amount
ALTER TABLE campaign ADD COLUMN "Remaining Goal Amount" int GENERATED ALWAYS AS (goal - pledged) STORED;

SELECT cl. first_name,
cl.last_name,
cl.email,
c."Remaining Goal Amount"
INTO email_contact_remaining_goal_amount
FROM contacts AS cl
INNER JOIN campaign AS c
ON (cl.contact_id = c.contact_id)
WHERE (c.outcome = 'live')
ORDER BY c."Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contact_remaining_goal_amount;


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

-- Rename Column ot meet request criter
ALTER TABLE campaign RENAME COLUMN "Remaining Goal Amount" TO "Left of Goal";

SELECT b.email,
b.first_name,
b.last_name,
b.cf_id,
c.company_name,
c.description,
c.end_date,
c."Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS b
INNER JOIN campaign AS c
ON (b.cf_id = c.cf_id)
WHERE (c.outcome = 'live')
ORDER BY b.last_name;
-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;
