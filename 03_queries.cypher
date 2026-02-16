//---Create---
CREATE
    (u:User {id: "u21", full_name: "Vasil Stoykov", email: "vstoykov@tu-sofia.bg"}),
    (s:Skill {id: "s_kafka", name: "Apache Kafka", description: "Event streaming platform"}),
    (c:Course {id: "c_kafka_doc", title: "Official Apache Kafka Documentation", provider: "Apache Software Foundation", duration_hours: 20}),
    (j:Job {id: "j_intern", title: "Developer Internship"}),
    (u) - [:HAS_SKILL {proficiency: "Beginner", experience: 0}] -> (s),
    (u) - [:HAS_TAKEN {completion_date: "2025-12-01", score: 80}] -> (c),
    (u) - [:WORKS_AS {company: "StartupBG", start_date: "2026-01-10", is_current: true, salary: 9600}] -> (j),
    (c) - [:TEACHES {level_gained: "Intermediate"}] -> (s);


//---Read---
MATCH (n) RETURN n;                                                                                    //returns all nodes

MATCH (u: User) WHERE u.full_name = "Vasil Stoykov" RETURN u;                                          //returns node with label User and name "Vasil Stoykov"

MATCH (u:User)-[:WORKS_AS {is_current: true}]->(j:Job) where j.id = "j_intern" RETURN u, j;            //returns nodes with labels User and Job where the User is currently working at this possition

MATCH (s:Skill)<-[:HAS_SKILL]-(User)-[:WORKS_AS]->(Job {id: "j_intern"}) RETURN s;                     //returns the skills that people have that also work the job specified

MATCH (s:Skill)<-[:HAS_SKILL]-(u:User)-[:WORKS_AS]->(j: Job {id: "j_sen_dev"}) RETURN u, s, j;         //better representation

//This query returns all users with salaries bigger than or equal to 80 000
MATCH (u:User)-[w:WORKS_AS]->()
WHERE w.salary >= 80000
RETURN u.full_name, w.salary; 

//This query returns all users that has a full_name field that starts with Vasil
MATCH (u:User)
WHERE u.full_name STARTS WITH "Vasil"
RETURN u;

//This query returns all users that work any developer job
MATCH (u:User)-[:WORKS_AS]->(j:Job)
WHERE j.title CONTAINS "Developer"
RETURN u;

//This query returns all users with either Java or React skills
MATCH (u:User)-[]->(s:Skill)
WHERE s.name in ["Java", "React"]
RETURN u;

//This query returns all users that are currently working at either BILLA of Kaufland
MATCH (u:User)-[w:WORKS_AS]->()
WHERE w.is_current = true AND (w.company = "BILLA" OR w.company = "Kaufland")
RETURN u;


//---Update---
MATCH (c:Course)
WHERE c.id = "c_kafka_doc"
//SET c.duration_hours = 25                                                                                                                     //update a specific property
//SET c += {title: "Official Apache Kafka Documentation"}                                                                                       //adds a brand new property
//SET c = {id: "c_kafka_doc", title: "Official Apache Kafka Documentation", provider: "Apache Software Foundation", duration_hours: 20}         //replaces all properties of a node
//SET c:SKILL                                                                                                                                   //adds a label to a node
RETURN c;


//---Delete---
MATCH (u:User)
WHERE u.id = "u21"
//DELETE u                      //remove node, works only when node has no relationships
//DETACH DELETE u               //remove node, works only when node has relationships 
//REMOVE u.email                //remove a property in a specific node
//REMOVE u:User                 //remove a label from a specific node
RETURN u;

//MATCH (n)                     //delete all nodes and relationships
//DETACH DELETE (n);

//---Aggregation---
//This query returns the average number of courses taken by the users that work a specified job
MATCH (j:Job {id: "j_sen_dev"})<-[:WORKS_AS]-(u:User)-[:HAS_TAKEN]->(c:Course)
WITH u, count(c) AS coursesPerUser
RETURN avg(coursesPerUser) AS averageCourses;

//This query returns the average number of courses taken by the users working for every possition, orders them by the least number of courses taken and limits the result rows to 3
MATCH (j:Job)<-[:WORKS_AS]-(u:User)-[:HAS_TAKEN]->(c:Course)
WITH j.title AS JobTitle, u, count(c) AS coursesPerUser
WITH JobTitle, avg(coursesPerUser) AS AverageCourses
RETURN JobTitle, AverageCourses
ORDER BY AverageCourses ASC
LIMIT 3;

//This query returns the min and max salaries for every job possition
MATCH (j:Job)<-[w:WORKS_AS {is_current: true}]-(u:User)
RETURN j.title AS Position, max(w.salary) AS MaxSalary, min(w.salary) AS MinSalary;


//---Role-Based Access Control---
//The following querries should be executed on the system db in order to create the roles with the specified access rights
CREATE USER auditor SET PASSWORD 'Welcome2026' CHANGE NOT REQUIRED;         //creates new role

GRANT ROLE reader TO auditor;                                               //grants specified role access

DENY READ {salary} ON GRAPH neo4j RELATIONSHIPS WORKS_AS TO reader          //deny read access of a specified property for the specified role
