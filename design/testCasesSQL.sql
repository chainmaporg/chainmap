-- User Sign up including company entity creation(Not reviewer) 

INSERT INTO company (company_name, company_info, company_email, company_phone, company_site)VALUES ('Chainmap', 'Blockchain Developer\'s Growth Platform and Solution Map

We as blockchain technology fans build ChainMap.org to support the community on use case analysis, finding solutions, building connections, and teaming up with similar minds.', 'chainmapsocial@gmail.com', '650-644-6928','http://chainmap.org/'); 


-- Developers signs up for a ChainMap Account
INSERT INTO `user` (company_id, firstname, lastname, user_name, user_email, user_phone, password, payment_address, is_reviewer)VALUES (1, 'George', 'Zhao','gzhao', 'gzhao@gmail.com', '619-552-0773',MD5('testing'), 'right Now I am not sure what will be the payment address', 0); 

INSERT INTO `user` (company_id, firstname, lastname, user_name, user_email, user_phone, password, payment_address, is_reviewer)VALUES (1, 'Carlos', 'Rivas','carlos.rivas', 'carlos.rivas@gmail.com', '+1-789-56-1234',MD5('testing'), '', 1); 

-- Another company with user and as a reviewer
INSERT INTO company (company_name, company_info, company_email, company_phone, company_site)VALUES ('4axiz', 'Software Development company', 'dhrubo@4axiz.com', '+88-01718837689','http://4axiz.com/');

INSERT INTO `user` (company_id, firstname, lastname, user_name, user_email, user_phone, password, payment_address, is_reviewer)VALUES (2, 'dhrubo', 'saha','the.dhrubo', 'the.dhrubo@gmail.com', '+1-575-418-5021',MD5('testing'), '', 1); 

-- Job posting by an user of a company.  --> contract job, and reviewer is required for this job

INSERT INTO `job_board` (user_id, job_description, job_location, job_qualifications, job_length, is_deleted, is_reviewer_required, posting_date)VALUES (2, 'Imagine as a patient instead of meeting one doctor you can have the expertise of dozen of doctors quicker and cheaper whatever your location. Imagine as a doctor to be able to collaborate in a much more efficient way and get much reward for your job. Imagine as a company to work with the best employees, to save the cost of management and to have the benefice of the network of the whole ecosystem. The medicaldao.io will be a set of tools / Dapp for large-scale collaboration in the medical industry to provide better, cheaper and faster medical care solutions.

The Medical DAO is a project undertaken by Medicalex corporate to solve major problems in the industry. The company has succeeded in the industry for more than 50 years, designing, producing and distributing medical devices.

We are looking for someone to join the team as a co-founder. His role will be to develop the MVP of the medical DAO which is a decentralized application build on top of the DAO Stack platform.', 'Los Angeles, CA','Javas script
Solidity
Knowledge of the decentralized autonomous organization and blockchain technologies
The ability to work at home
Motivation', 3, 0,1, '2018-06-06 23:59:59'); 

-- Developer can save the posted job

INSERT INTO `saved_jobs` (user_id, job_id, saved_date, is_saved)VALUES (3, 1, '2018-06-07 23:59:59', '2018-06-06 23:59:59');

-- Developer can un save the saved job

UPDATE saved_jobs SET is_saved = 0 WHERE user_id = 3 and job_id = 1;

-- Employer accepts applicants (Community rewards employer) and the job gets started (Community rewards developer)

INSERT INTO `job_history` (job_id, developer_id, job_status, application_acceptance_date)VALUES (1, 3, 1, '2018-06-08 23:59:59');

-- Developer is able to start job or apply (Community rewards developer)

UPDATE job_history SET job_status = 2, job_starting_date = '2018-06-06 23:59:59' WHERE job_history.job_id = 1;


-- Developer is able to stop the job

UPDATE job_history SET job_status = 3, job_stoping_date = '2018-06-10 23:59:59' WHERE job_history.job_id = 1;

-- Job is reviewed by another reviewer

UPDATE job_history SET job_status = 4, job_reviewing_date = '2018-06-10 23:59:59', job_reviewed_by = 2 WHERE job_history.job_id = 1;

-- Job is Accepted by employer

UPDATE job_history SET job_status = 5, job_acceptance_date = '2018-06-12 23:59:59' WHERE job_history.job_id = 1;

-- Job is paid by employer

UPDATE job_history SET job_status = 6, job_payment_date = '2018-06-15 23:59:59' WHERE job_history.job_id = 1;


-- Employer is able to “Unpost” Job once position has been filled

UPDATE job_board SET is_deleted = 1 WHERE job_id = 1;
