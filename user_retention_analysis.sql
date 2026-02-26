-- User Retention SQL Analysis

-- 1. Total Users
SELECT COUNT(*) as Total_Users FROM users;

-- 2. Churn Rate Analysis
SELECT 
  status,
  COUNT(*) as Count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users), 2) as Percentage
FROM users
GROUP BY status;

-- 3. Plan wise Churn
SELECT 
  plan,
  status,
  COUNT(*) as Count
FROM users
GROUP BY plan, status;

-- 4. Monthly Signups Trend
SELECT 
  strftime('%Y-%m', signup_date) as Month,
  COUNT(*) as New_Users
FROM users
GROUP BY Month;
ORDER BY Month;

-- 5. Senior Citizen Churn Analysis
SELECT 
  senior_citizen,
  status,
  COUNT(*) as Count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users), 2) as Percentage
FROM users
GROUP BY senior_citizen, status;

-- 6. Average Tenure of Churned vs Active Users
SELECT 
  status,
  ROUND(AVG(tenure), 2) as Avg_Tenure_Months
FROM users
GROUP BY status;

-- 7. High Risk Customers (Short tenure + Monthly plan)
SELECT 
  customer_id,
  plan,
  tenure,
  status
FROM users
WHERE plan = 'Month-to-month' AND tenure < 6
ORDER BY tenure ASC;

-- 8. Revenue Impact of Churn
SELECT 
  status,
  ROUND(SUM(monthly_charges), 2) as Total_Revenue,
  ROUND(AVG(monthly_charges), 2) as Avg_Monthly_Charge
FROM users
GROUP BY status;

-- 9. Contract Type vs Churn Rate
SELECT 
  contract_type,
  COUNT(*) as Total,
  SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) as Churned,
  ROUND(SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as Churn_Rate
FROM users
GROUP BY contract_type;

-- 10. Top Reasons for Churn (if reason column exists)
SELECT 
  churn_reason,
  COUNT(*) as Count
FROM users
WHERE status = 'Churned'
GROUP BY churn_reason
ORDER BY Count DESC;
