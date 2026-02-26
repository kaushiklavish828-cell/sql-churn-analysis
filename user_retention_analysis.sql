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
GROUP BY Month
ORDER BY Month;