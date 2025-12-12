use bank_Aprameya;
SELECT DISTINCT s.CustomerName
FROM Depositer s
WHERE NOT EXISTS (
    SELECT BranchName 
    FROM Branch b
    WHERE b.BranchCity = 'Delhi'
      AND NOT EXISTS (
        SELECT 1
        FROM Depositer d 
        JOIN BankAccount t ON d.AccNo = t.AccNo
        WHERE d.CustomerName = s.CustomerName
          AND t.BranchName = b.BranchName
      )
);
SELECT DISTINCT C.CustomerName
FROM BankCustomer C
JOIN Loan L ON L.BranchName IN (SELECT BranchName FROM Branch)
WHERE C.CustomerName NOT IN (
    SELECT DISTINCT CustomerName FROM Depositer
);
SELECT DISTINCT D.CustomerName
FROM Depositer D
JOIN BankAccount B ON D.AccNo = B.AccNo
JOIN Loan L ON L.BranchName = B.BranchName
WHERE B.BranchName IN (
    SELECT BranchName FROM Branch WHERE BranchCity = 'Bangalore'
);
SELECT BranchName
FROM Branch
WHERE Assets > ALL (
    SELECT Assets FROM Branch WHERE BranchCity = 'Bangalore'
);
DELETE FROM BankAccount
WHERE BranchName IN (
    SELECT BranchName FROM Branch WHERE BranchCity = 'Bombay'
);
UPDATE BankAccount
SET Balance = Balance * 1.05;
select * from BankAccount;