// ==========================================
// 1. THE ONTOLOGY (The Entities in the World)
// ==========================================

// SKILLS
CREATE
  (s_java:Skill {id: "s_java", name: "Java", description: "Backend programming"}),
  (s_react:Skill {id: "s_react", name: "React", description: "Frontend web development"}),
  (s_sql:Skill {id: "s_sql", name: "SQL", description: "Database querying"}),
  (s_wood:Skill {id: "s_wood", name: "Woodworking", description: "Carpentry and joinery"}),
  (s_pipe:Skill {id: "s_pipe", name: "Plumbing", description: "Pipefitting and water systems"}),
  (s_weld:Skill {id: "s_weld", name: "Welding", description: "Metal fabrication"}),
  (s_firstaid:Skill {id: "s_firstaid", name: "First Aid", description: "Emergency medical response"}),
  (s_care:Skill {id: "s_care", name: "Patient Care", description: "Clinical nursing skills"}),
  (s_cust:Skill {id: "s_cust", name: "Customer Service", description: "Client relations and support"}),
  (s_inv:Skill {id: "s_inv", name: "Inventory Management", description: "Stock control"}),
  (s_acc:Skill {id: "s_acc", name: "Accounting", description: "Financial reporting"}),
  (s_excel:Skill {id: "s_excel", name: "Advanced Excel", description: "Financial modeling"});

// COURSES (Varied Education Levels and Providers)
CREATE
  (c_su_cs:Course {id: "c_su_cs", title: "BSc Computer Science", provider: "Sofia University (SU)", duration_hours: 4000}),
  (c_softuni:Course {id: "c_softuni", title: "Java Web Developer Bootcamp", provider: "SoftUni", duration_hours: 800}),
  (c_telerik:Course {id: "c_telerik", title: "Frontend Masterclass", provider: "Telerik Academy", duration_hours: 600}),
  (c_unwe_fin:Course {id: "c_unwe_fin", title: "BSc Finance", provider: "UNWE", duration_hours: 4000}),
  (c_med_uni:Course {id: "c_med_uni", title: "BSc Nursing", provider: "Medical University", duration_hours: 4500}),
  (c_redcross:Course {id: "c_redcross", title: "Certified First Responder", provider: "Bulgarian Red Cross", duration_hours: 120}),
  (c_trade_bg:Course {id: "c_trade_bg", title: "Vocational Construction", provider: "UACG Vocational", duration_hours: 3000}),
  (c_highschool:Course {id: "c_highschool", title: "General High School Diploma", provider: "Public School System", duration_hours: 8000});

// JOB ROLES (Base titles. Salaries and Companies belong to the specific employment relationship)
CREATE
  (j_jun_dev:Job {id: "j_jun_dev", title: "Junior Developer"}),
  (j_sen_dev:Job {id: "j_sen_dev", title: "Senior Developer"}),
  (j_accountant:Job {id: "j_accountant", title: "Accountant"}),
  (j_carpenter:Job {id: "j_carpenter", title: "Master Carpenter"}),
  (j_plumber:Job {id: "j_plumber", title: "Plumber"}),
  (j_nurse:Job {id: "j_nurse", title: "Registered Nurse"}),
  (j_cashier:Job {id: "j_cashier", title: "Cashier"}),
  (j_store_mgr:Job {id: "j_store_mgr", title: "Store Manager"});

// ==========================================
// 2. SYSTEM RULES (Course TEACHES)
// ==========================================

WITH 1 as dummy
MATCH (c_su:Course {id: "c_su_cs"}), (c_soft:Course {id: "c_softuni"}), (c_trd:Course {id: "c_trade_bg"}), (c_med:Course {id: "c_med_uni"}), (c_tel:Course {id: "c_telerik"}), (c_unwe:Course {id: "c_unwe_fin"}), (c_rc:Course {id: "c_redcross"})
MATCH (s_java:Skill {id: "s_java"}), (s_sql:Skill {id: "s_sql"}), (s_wood:Skill {id: "s_wood"}), (s_care:Skill {id: "s_care"}), (s_react:Skill {id: "s_react"}), (s_acc:Skill {id: "s_acc"}), (s_firstaid:Skill {id: "s_firstaid"})
MERGE (c_su)-[:TEACHES {level_gained: "Intermediate"}]->(s_java)
MERGE (c_su)-[:TEACHES {level_gained: "Intermediate"}]->(s_sql)
MERGE (c_soft)-[:TEACHES {level_gained: "Advanced"}]->(s_java)
MERGE (c_tel)-[:TEACHES {level_gained: "Advanced"}]->(s_react)
MERGE (c_trd)-[:TEACHES {level_gained: "Advanced"}]->(s_wood)
MERGE (c_med)-[:TEACHES {level_gained: "Advanced"}]->(s_care)
MERGE (c_med)-[:TEACHES {level_gained: "Advanced"}]->(s_firstaid)
MERGE (c_rc)-[:TEACHES {level_gained: "Intermediate"}]->(s_firstaid)
MERGE (c_unwe)-[:TEACHES {level_gained: "Intermediate"}]->(s_acc)

// ==========================================
// 3. THE 20 REAL-WORLD CASES (User by User)
// ==========================================

// --- User 1: The Traditional University Tech Path ---
WITH 1 as dummy 
MATCH (c_su:Course {id: "c_su_cs"}), (s_java:Skill {id: "s_java"}), (s_sql:Skill {id: "s_sql"}), (j_jun:Job {id: "j_jun_dev"}), (j_sen:Job {id: "j_sen_dev"})
CREATE (u:User {id: "u1", full_name: "Alexander Petrov", email: "alex@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2015-07-01", score: 85}]->(c_su)
CREATE (u)-[:HAS_SKILL {proficiency: "Expert", experience: 8}]->(s_java)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 6}]->(s_sql)
CREATE (u)-[:WORKS_AS {company: "SAP Labs", start_date: "2015-09-01", is_current: false, salary: 45000}]->(j_jun)
CREATE (u)-[:WORKS_AS {company: "VMware", start_date: "2019-01-10", is_current: true, salary: 110000}]->(j_sen);

// --- User 2: The Bootcamp Career-Switcher ---
WITH 1 as dummy 
MATCH (c_hs:Course {id: "c_highschool"}), (c_soft:Course {id: "c_softuni"}), (s_java:Skill {id: "s_java"}), (s_react:Skill {id: "s_react"}), (j_jun:Job {id: "j_jun_dev"}), (j_sen:Job {id: "j_sen_dev"})
CREATE (u:User {id: "u2", full_name: "Maria Ivanova", email: "maria@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2012-05-20", score: 90}]->(c_hs)
CREATE (u)-[:HAS_TAKEN {completion_date: "2018-12-01", score: 98}]->(c_soft)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 5}]->(s_java)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 3}]->(s_react)
CREATE (u)-[:WORKS_AS {company: "Dreamix", start_date: "2019-02-01", is_current: false, salary: 38000}]->(j_jun)
CREATE (u)-[:WORKS_AS {company: "SiteGround", start_date: "2022-06-15", is_current: true, salary: 95000}]->(j_sen);

// --- User 3: The Frontend Specialist ---
WITH 1 as dummy 
MATCH (c_tel:Course {id: "c_telerik"}), (s_react:Skill {id: "s_react"}), (j_jun:Job {id: "j_jun_dev"})
CREATE (u:User {id: "u3", full_name: "Georgi Kolev", email: "georgi@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2023-08-15", score: 92}]->(c_tel)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 1}]->(s_react)
CREATE (u)-[:WORKS_AS {company: "Chaos Group", start_date: "2023-09-01", is_current: true, salary: 42000}]->(j_jun);

// --- User 4: High School directly to Retail ---
WITH 1 as dummy 
MATCH (c_hs:Course {id: "c_highschool"}), (s_cust:Skill {id: "s_cust"}), (j_cash:Job {id: "j_cashier"})
CREATE (u:User {id: "u4", full_name: "Elena Marinova", email: "elena@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2021-05-24", score: 75}]->(c_hs)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 2}]->(s_cust)
CREATE (u)-[:WORKS_AS {company: "Fantastico", start_date: "2021-08-01", is_current: true, salary: 18000}]->(j_cash);

// --- User 5: The Retail Career Ladder ---
WITH 1 as dummy 
MATCH (c_hs:Course {id: "c_highschool"}), (s_cust:Skill {id: "s_cust"}), (s_inv:Skill {id: "s_inv"}), (j_cash:Job {id: "j_cashier"}), (j_mgr:Job {id: "j_store_mgr"})
CREATE (u:User {id: "u5", full_name: "Stefan Hristov", email: "stefan@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2010-05-24", score: 80}]->(c_hs)
CREATE (u)-[:HAS_SKILL {proficiency: "Expert", experience: 10}]->(s_cust)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 5}]->(s_inv)
CREATE (u)-[:WORKS_AS {company: "Kaufland", start_date: "2011-03-01", is_current: false, salary: 16000}]->(j_cash)
CREATE (u)-[:WORKS_AS {company: "Kaufland", start_date: "2016-01-10", is_current: true, salary: 42000}]->(j_mgr);

// --- User 6: The Veteran Master Carpenter ---
WITH 1 as dummy 
MATCH (c_trd:Course {id: "c_trade_bg"}), (s_wood:Skill {id: "s_wood"}), (j_carp:Job {id: "j_carpenter"})
CREATE (u:User {id: "u6", full_name: "Dimitar Zhelev", email: "mitko.wood@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "1998-06-15", score: 95}]->(c_trd)
CREATE (u)-[:HAS_SKILL {proficiency: "Master", experience: 25}]->(s_wood)
CREATE (u)-[:WORKS_AS {company: "Zhelev Woodworks", start_date: "2000-01-01", is_current: true, salary: 85000}]->(j_carp);

// --- User 7: The Corporate Plumber ---
WITH 1 as dummy 
MATCH (c_trd:Course {id: "c_trade_bg"}), (s_pipe:Skill {id: "s_pipe"}), (s_weld:Skill {id: "s_weld"}), (j_plum:Job {id: "j_plumber"})
CREATE (u:User {id: "u7", full_name: "Vasil Todorov", email: "vasko.pipes@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2015-06-15", score: 82}]->(c_trd)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 8}]->(s_pipe)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 4}]->(s_weld)
CREATE (u)-[:WORKS_AS {company: "Glavbolgarstroy", start_date: "2016-03-01", is_current: true, salary: 55000}]->(j_plum);

// --- User 8: University Educated Nurse ---
WITH 1 as dummy 
MATCH (c_med:Course {id: "c_med_uni"}), (s_care:Skill {id: "s_care"}), (s_firstaid:Skill {id: "s_firstaid"}), (j_nur:Job {id: "j_nurse"})
CREATE (u:User {id: "u8", full_name: "Elena Vasileva", email: "elena.v@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2018-07-01", score: 98}]->(c_med)
CREATE (u)-[:HAS_SKILL {proficiency: "Expert", experience: 6}]->(s_care)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 6}]->(s_firstaid)
CREATE (u)-[:WORKS_AS {company: "Acibadem City Clinic", start_date: "2018-09-01", is_current: true, salary: 65000}]->(j_nur);

// --- User 9: Red Cross to Trauma Staff ---
WITH 1 as dummy 
MATCH (c_rc:Course {id: "c_redcross"}), (s_firstaid:Skill {id: "s_firstaid"}), (j_nur:Job {id: "j_nurse"})
CREATE (u:User {id: "u9", full_name: "Krasimir Nikolov", email: "krasi.n@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2020-11-15", score: 100}]->(c_rc)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 3}]->(s_firstaid)
CREATE (u)-[:WORKS_AS {company: "Pirogov Emergency Hospital", start_date: "2021-01-10", is_current: true, salary: 48000}]->(j_nur);

// --- User 10: The Corporate Accountant ---
WITH 1 as dummy 
MATCH (c_unwe:Course {id: "c_unwe_fin"}), (s_acc:Skill {id: "s_acc"}), (s_excel:Skill {id: "s_excel"}), (j_acc:Job {id: "j_accountant"})
CREATE (u:User {id: "u10", full_name: "Silvia Gospodinova", email: "silvia.g@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2016-06-30", score: 89}]->(c_unwe)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 7}]->(s_acc)
CREATE (u)-[:HAS_SKILL {proficiency: "Expert", experience: 7}]->(s_excel)
CREATE (u)-[:WORKS_AS {company: "PwC Bulgaria", start_date: "2016-09-01", is_current: true, salary: 72000}]->(j_acc);

// --- User 11: Retail to Finance (The Multi-Disciplinary) ---
WITH 1 as dummy 
MATCH (c_hs:Course {id: "c_highschool"}), (c_unwe:Course {id: "c_unwe_fin"}), (s_cust:Skill {id: "s_cust"}), (s_acc:Skill {id: "s_acc"}), (j_cash:Job {id: "j_cashier"}), (j_acc:Job {id: "j_accountant"})
CREATE (u:User {id: "u11", full_name: "Nikolay Borisov", email: "niki.b@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2013-05-20", score: 85}]->(c_hs)
CREATE (u)-[:HAS_TAKEN {completion_date: "2017-06-30", score: 92}]->(c_unwe)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 4}]->(s_cust)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 5}]->(s_acc)
CREATE (u)-[:WORKS_AS {company: "BILLA", start_date: "2013-08-01", is_current: false, salary: 14000}]->(j_cash)
CREATE (u)-[:WORKS_AS {company: "KPMG", start_date: "2018-01-15", is_current: true, salary: 68000}]->(j_acc);

// --- User 12: The Burnout Career-Switcher (Tech to Trades) ---
WITH 1 as dummy 
MATCH (c_su:Course {id: "c_su_cs"}), (s_java:Skill {id: "s_java"}), (s_wood:Skill {id: "s_wood"}), (j_jun:Job {id: "j_jun_dev"}), (j_carp:Job {id: "j_carpenter"})
CREATE (u:User {id: "u12", full_name: "Kamen Asenov", email: "kamen.woodcraft@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2016-07-01", score: 88}]->(c_su)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 3}]->(s_java)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 5}]->(s_wood)
CREATE (u)-[:WORKS_AS {company: "Musala Soft", start_date: "2016-09-01", is_current: false, salary: 45000}]->(j_jun)
CREATE (u)-[:WORKS_AS {company: "Asenov Custom Furniture", start_date: "2020-01-15", is_current: true, salary: 60000}]->(j_carp);

// --- User 13: The Hustler (Working Two Jobs to Break into Tech) ---
WITH 1 as dummy 
MATCH (c_tel:Course {id: "c_telerik"}), (c_hs:Course {id: "c_highschool"}), (s_react:Skill {id: "s_react"}), (s_cust:Skill {id: "s_cust"}), (j_cash:Job {id: "j_cashier"}), (j_jun:Job {id: "j_jun_dev"})
CREATE (u:User {id: "u13", full_name: "Desislava Ruseva", email: "desi.codes@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2019-05-20", score: 82}]->(c_hs)
CREATE (u)-[:HAS_TAKEN {completion_date: "2023-11-01", score: 95}]->(c_tel)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 1}]->(s_react)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 4}]->(s_cust)
CREATE (u)-[:WORKS_AS {company: "Lidl Bulgaria", start_date: "2020-02-01", is_current: true, salary: 22000}]->(j_cash)
CREATE (u)-[:WORKS_AS {company: "StartupBG", start_date: "2024-01-15", is_current: true, salary: 24000}]->(j_jun);

// --- User 14: The High-Paid Blue Collar ---
WITH 1 as dummy 
MATCH (c_trd:Course {id: "c_trade_bg"}), (s_weld:Skill {id: "s_weld"}), (s_pipe:Skill {id: "s_pipe"}), (j_plum:Job {id: "j_plumber"})
CREATE (u:User {id: "u14", full_name: "Borislav Hristov", email: "bobi.weld@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2005-06-15", score: 70}]->(c_trd)
CREATE (u)-[:HAS_SKILL {proficiency: "Master", experience: 18}]->(s_weld)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 10}]->(s_pipe)
CREATE (u)-[:WORKS_AS {company: "Atomstroyexport", start_date: "2010-04-01", is_current: true, salary: 135000}]->(j_plum);

// --- User 15: Corporate IT at a Non-Tech Company ---
WITH 1 as dummy 
MATCH (c_su:Course {id: "c_su_cs"}), (s_java:Skill {id: "s_java"}), (s_sql:Skill {id: "s_sql"}), (s_inv:Skill {id: "s_inv"}), (j_sen:Job {id: "j_sen_dev"})
CREATE (u:User {id: "u15", full_name: "Tanya Vasileva", email: "tanya.v@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2010-07-01", score: 92}]->(c_su)
CREATE (u)-[:HAS_SKILL {proficiency: "Expert", experience: 12}]->(s_java)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 10}]->(s_sql)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 5}]->(s_inv) 
CREATE (u)-[:WORKS_AS {company: "Kaufland IT Services", start_date: "2015-08-01", is_current: true, salary: 105000}]->(j_sen);

// --- User 16: The Maternity Leave Returner (Finance) ---
WITH 1 as dummy 
MATCH (c_unwe:Course {id: "c_unwe_fin"}), (s_acc:Skill {id: "s_acc"}), (s_excel:Skill {id: "s_excel"}), (j_acc:Job {id: "j_accountant"})
CREATE (u:User {id: "u16", full_name: "Nadezhda Spasova", email: "nadia.finance@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2012-06-30", score: 96}]->(c_unwe)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 8}]->(s_acc)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 8}]->(s_excel)
CREATE (u)-[:WORKS_AS {company: "Deloitte Bulgaria", start_date: "2012-09-01", is_current: false, salary: 85000}]->(j_acc)
CREATE (u)-[:WORKS_AS {company: "Local Accounting Ltd.", start_date: "2021-03-01", is_current: true, salary: 55000}]->(j_acc);

// --- User 17: Failed Med Student to Retail Management ---
WITH 1 as dummy 
MATCH (c_med:Course {id: "c_med_uni"}), (s_firstaid:Skill {id: "s_firstaid"}), (s_cust:Skill {id: "s_cust"}), (s_inv:Skill {id: "s_inv"}), (j_cash:Job {id: "j_cashier"}), (j_mgr:Job {id: "j_store_mgr"})
CREATE (u:User {id: "u17", full_name: "Yordan Markov", email: "dancho.m@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2016-02-15", score: 55}]->(c_med)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 2}]->(s_firstaid)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 7}]->(s_cust)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 4}]->(s_inv)
CREATE (u)-[:WORKS_AS {company: "BILLA", start_date: "2016-05-01", is_current: false, salary: 15000}]->(j_cash)
CREATE (u)-[:WORKS_AS {company: "BILLA", start_date: "2020-09-01", is_current: true, salary: 48000}]->(j_mgr);

// --- User 18: The Perpetual Student (Over-educated, Under-experienced) ---
WITH 1 as dummy 
MATCH (c_su:Course {id: "c_su_cs"}), (c_soft:Course {id: "c_softuni"}), (c_tel:Course {id: "c_telerik"}), (s_java:Skill {id: "s_java"}), (s_react:Skill {id: "s_react"}), (j_jun:Job {id: "j_jun_dev"})
CREATE (u:User {id: "u18", full_name: "Petar Georgiev", email: "pesho.student@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2018-07-01", score: 78}]->(c_su)
CREATE (u)-[:HAS_TAKEN {completion_date: "2020-12-01", score: 85}]->(c_soft)
CREATE (u)-[:HAS_TAKEN {completion_date: "2022-08-15", score: 88}]->(c_tel)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 2}]->(s_java)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 1}]->(s_react)
CREATE (u)-[:WORKS_AS {company: "Small Web Agency", start_date: "2023-01-10", is_current: true, salary: 35000}]->(j_jun);

// --- User 19: The Fast-Track Nepotism Case ---
WITH 1 as dummy 
MATCH (c_unwe:Course {id: "c_unwe_fin"}), (s_acc:Skill {id: "s_acc"}), (s_cust:Skill {id: "s_cust"}), (j_mgr:Job {id: "j_store_mgr"})
CREATE (u:User {id: "u19", full_name: "Rumyana Kostova", email: "rumi.boss@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2023-06-30", score: 80}]->(c_unwe)
CREATE (u)-[:HAS_SKILL {proficiency: "Intermediate", experience: 1}]->(s_acc)
CREATE (u)-[:HAS_SKILL {proficiency: "Beginner", experience: 0}]->(s_cust)
CREATE (u)-[:WORKS_AS {company: "Family Retail Enterprise", start_date: "2023-07-01", is_current: true, salary: 90000}]->(j_mgr);

// --- User 20: The Corporate Medic ---
WITH 1 as dummy 
MATCH (c_med:Course {id: "c_med_uni"}), (s_care:Skill {id: "s_care"}), (s_acc:Skill {id: "s_acc"}), (j_nur:Job {id: "j_nurse"}), (j_acc:Job {id: "j_accountant"})
CREATE (u:User {id: "u20", full_name: "Simeon Mihaylov", email: "simo.medical@email.com"})
CREATE (u)-[:HAS_TAKEN {completion_date: "2010-07-01", score: 92}]->(c_med)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 8}]->(s_care)
CREATE (u)-[:HAS_SKILL {proficiency: "Advanced", experience: 5}]->(s_acc)
CREATE (u)-[:WORKS_AS {company: "Tokuda Hospital", start_date: "2011-01-15", is_current: false, salary: 50000}]->(j_nur)
CREATE (u)-[:WORKS_AS {company: "Tokuda Hospital Administration", start_date: "2019-06-01", is_current: true, salary: 78000}]->(j_acc);