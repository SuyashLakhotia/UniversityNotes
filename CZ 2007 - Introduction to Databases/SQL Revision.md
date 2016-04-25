# Structured Query Language (SQL)

<!-- Lecture 1 -->

- Case-insensitive (except for strings).
- Whitespace is ignored.
- `;` ends statements.
- `/*..*/` wraps comments.
- SQL can be divided into three aspects:
	- Data Manipulation Language (DML)
		- Perform queries
		- Perform updates
	- Data Definition Language (DDL)
		- Create databases, tables, indices
		- Create views
		- Specify authorization
		- Specify integrity constraints
	- Embedded SQL

## Query Basics
```
SELECT	attribute(s)
FROM	Relation(s)
WHERE	condition(s);
```
```
SELECT * 						/* all attributes */
SELECT oldName AS newName 		/* rename attribute(s) */
SELECT oldVal*120 AS newVal 	/* mathematical expression */
```
```
WHERE attr1 {> | < | >= | <= | = | <>} attr2
WHERE cond1 {AND | OR} [NOT] cond2		/* nested conditions */
WHERE attr BETWEEN val1 AND val2		/* range of values */
WHERE attr LIKE '<pattern>' 			/* pattern matching */
WHERE attr IN (val1, val2, val3)		/* set of values (useful for nested subqueries) */
WHERE attr {IS NULL | IS NOT NULL}		/* NULL values */
```

#### Pattern Matching
- `[A-Z]`, `[a-z]`, `[a-Z]`, `[0-9]` etc.
- `%` = any string
- `_` = any character

#### 3-Value Logic
- SQL is really 3-valued logic – `TRUE`, `FALSE`, `UNKNOWN`.
- When comparing to NULL values, the truth value is `UNKNOWN`.
- A query only produces a tuple in the answer if the truth value for `WHERE` is `TRUE`.
- `NOT UNKNOWN = UNKNOWN`

<!-- /Lecture 1 -->

<!-- Lecture 2 -->

## ORDER BY Clause
- The query result returned is not ordered on any attribute by default.
- The data can be ordered using `ORDER BY attr [ASC (default) | DESC]`.
- `ORDER BY X, Y` = Order by `X` first and use `Y` to break ties.
- NULL < Non-NULL.

```
SELECT attr1, attr2, attr3
FROM Relation
WHERE condition
ORDER BY attr1 DESC, attr2 ASC;
```

## Multi-Relation Queries
- Queries can have more than one relation in the `FROM` clause. In order to avoid ambiguity amongst attribute names, `<relation>.<attribute>` can be used.

```
SELECT R.attr1, S.attr2
FROM Relation1 AS R, Relation2 AS S
WHERE R.attr1 = value AND S.attr2 = value;
```

- A query may also use two copies of the same relation. The two copies can be distinguished using *tuple-variables* in the `FROM` clause.

```
SELECT R1.attr, R2.attr
FROM Relation R1, Relation R2
WHERE condition;
```

## Subqueries
1. **Scalar Subquery:** Returns a single value, which is then used in a comparison. If the query is written so that it expects a subquery to return a single value and it returns multiple values or no values, a run-time error occurs.
2. **Row Subquery:** Returns a single row, which may have multiple columns.
3. **Table Subquery:** Returns one or more columns and multiple rows.

### Scalar Subquery
```
SELECT attr
FROM Relation
WHERE attr = (SELECT attr FROM Relation WHERE condition);
```

### Table Subquery
```
SELECT attr
FROM Relation
WHERE attr IN (SELECT attr FROM Relation WHERE condition);
```
```
SELECT attr
FROM Relation
WHERE attr {> | < | >= | <= | = | <>} ALL (SELECT attr FROM Relation);
```
```
SELECT attr
FROM Relation
WHERE attr {> | < | >= | <= | = | <>} SOME (SELECT attr FROM Relation);
```
```
SELECT R.attr
FROM (SELECT attr FROM Relation WHERE condition) AS R
WHERE condition
```
```
/* 'EXISTS (Relation)' is TRUE iff Relation is not empty.
 * Conversely, 'NOT EXISTS (Relation)' is TRUE iff Relation is empty. */

SELECT R1.attr1
FROM Relation R1
WHERE EXISTS	(SELECT * FROM Relation R2
				WHERE R2.attr1 = R1.attr1 AND R1.attr2 <> R2.attr2);
```

### Correlated & Uncorrelated Subqueries
- A nested query is correlated with the outer query if it contains a reference to an attribute in the outer query.
- A nested query is correlated with the outer query if it must be recomputed for every tuple produced by the outer query.
- Subqueries should be avoided if they are not correlated as query optimisers do not generally do a good job at optimising queries containing subqueries.
- Uncorrelated subqueries can be converted to non-nested queries using joins.

<!-- /Lecture 2 -->

<!-- Lecture 3 -->

### Subquery Syntax Rules
- The `ORDER BY` clause cannot be used in a subquery.
- The number of attributes in the `SELECT` clause of the subquery must match the number of attributes it is being compared to.
- Column names in a subquery refer to the table name in the `FROM` clause of the subquery by default.
- When the result of a subquery is used as an operand, it must be the right operand.

## Set Operations
- `UNION`, `INTERSECT`, `EXCEPT`
- Generally used to combine the results of two separate SQL queries.
- Syntax:	`(subquery) UNION (subquery)`

### SELECT INTO
- The result of a `SELECT` statement can be stored in a temporary table using the `INTO` keyword.
- `SELECT * INTO TempTable FROM Relation WHERE condition`

## Bag Semantics
### Bags & Sets
- Relations in SQL are *bags* instead of sets.
- Default for `SELECT-FROM-WHERE` is bag.
- Default for `UNION`, `INTERSECT` and `EXCEPT` is set.

### How to change the default?
- Force set semantics with `DISTINCT` after `SELECT`.
- Force bag semantics with `ALL` after `UNION`, `INTERSECT` etc.

```
SELECT DISTINCT attr
FROM Relation;
```
```
(subquery) UNION ALL (subquery);
```

## Joins
- SQL provides a number of expression forms that act like varieties of join in relational algebra.
	- But using bag semantics, not set semantics.
- These expressions can be stand-alone queries or used in place of relations in a `FROM` clause.

```
R NATURAL JOIN S	/* Natural Join */
R CROSS JOIN S		/* Cross Product */
```
```
/* Theta Join */
R JOIN S ON <condition>
R INNER JOIN S USING (<attribute list>)
```
```
/* Outer Join */
R [LEFT | RIGHT | FULL (default)] OUTER [NATURAL] JOIN S [ON <condition>]
```

## Aggregation & Grouping
### Aggregate Functions
- `COUNT` - returns the number of values in a column
- `SUM` - returns the sum of the values in a column
- `AVG` - returns the average of the values in a column
- `MIN` - returns the smallest value in a column
- `MAX` - returns the largest value in a column

#### Rules
- `SUM` & `AVG` apply only to numeric fields.
- Except for `COUNT(*)`, all functions ignore NULL values.
- Use `DISTINCT` to eliminate duplicates. Example: `COUNT(DISTINCT attr)`.

### GROUP BY & HAVING Clauses
- A `SELECT-FROM-WHERE` expression can be followed by a `GROUP BY` and a list of attributes.
	- The relation that results from the `SELECT-FROM-WHERE` is grouped according to the values of all those attributes and any aggregation is only applied within each group.
- A column name cannot appear in the `SELECT` part of the query unless it is part of an aggregate function or in the list of `GROUP BY` attributes. However, a column can be in the `GROUP BY` clause without being in the `SELECT` clause.

<!-- /Lecture 3 -->

<!-- Lecture 4 -->

- `HAVING <condition>` can follow a `GROUP BY` clause. If so, the condition applies to each group and groups not satisfying the condition are eliminated.
	- These conditions may refer to any relation or tuple-variable in the `FROM` clause.
	- They may refer to attributes of those relations as long as the attribute makes sense within a group i.e. they must have a single value per group i.e. it is either:
		- a grouping attribute
		- an aggregated attribute

```
SELECT attr1, AVG(attr2) AS attr3
FROM Relation
GROUP BY attr1
HAVING COUNT(attr1) >= 2;
```

#### EVERY & ANY Functions
- `HAVING <condition> AND EVERY/ANY <condition>`
- Every (or any) row in a group must satisfy this condition.

```
SELECT attr1, AVG(attr2) AS attr3
FROM Relation
GROUP BY attr1
HAVING COUNT(attr1) >= 2 AND EVERY (attr2 < value);
```

## Query Syntax Summary
```
SELECT			<attribute list>
FROM			<table list>
[WHERE			(condition)]
[GROUP BY		<grouping attributes>]
[HAVING			<group condition>]
[ORDER BY		<attribute list>];
```

- A query is evaluated by first applying the `WHERE` clause, then `GROUP BY` and `HAVING`, and finally the `SELECT` clause.

<br>
<hr>
<br>

## Creating, Deleting & Updating Tables
```
/* Creating a Table */
CREATE TABLE name (
	attr1 type {NOT NULL | PRIMARY KEY | DEFAULT value},
	attr2 type
);

/* Adding & Deleting Attributes */
ALTER TABLE name ADD attr3 type;
ALTER TABLE name DROP attr1;

/* Deleting a Table */
DROP TABLE name;
```

#### Data Types:
- INT or INTEGER, REAL or FLOAT
- CHAR(n), VARCHAR(n)
- DATE ['yyyy-mm-dd']
- TIME ['hh:mm:ss']

## Database Modifications
```
/* Insertion */
INSERT INTO Relation VALUES (val, val, val);
INSERT INTO Relation(attr, attr) VALUES (val, val);
INSERT INTO Relation (subquery);

/* Deletion */
DELETE FROM Relation WHERE condition;
DELETE FROM Relation AS R WHERE EXISTS (subquery);

/* Updates */
UPDATE Relation SET attr = val WHERE condition;
```

## Constraints
- A relationship among data elements that a DBMS is required to enforce.
- Keys, Foreign Keys or Referential Integrity, Value-based Constraints, Tuple-based Constraints, Assertions.

### PRIMARY KEY vs UNIQUE
- Some DBMS automatically create an *index* in response to `PRIMARY KEY` but not `UNIQUE`.
- There can only be one `PRIMARY KEY` but several `UNIQUE` attributes.
- `PRIMARY KEY` can never be NULL.
- `UNIQUE` attributes may have NULLs.

```
attr type {PRIMARY KEY | UNIQUE}	/* for single attribute key */
PRIMARY KEY (attr1, attr2)			/* for multi-attribute key */
```

### NOT NULL & DEFAULT Value
```
attr type NOT NULL
attr type DEFAULT val
```

### Foreign Key
```
attr type,
FOREIGN KEY attr REFERENCES OtherRelation(attr)
[ON DELETE {SET NULL | CASCADE}]
[ON UPDATE {SET NULL | CASCADE}]
```

- If `ON DELETE` or `ON UPDATE` is not specified, the default behaviour is to reject any change on a referenced tuple in `OtherRelation`.

<!-- /Lecture 4 -->

<!-- Lecture 5 -->

### Attribute-Based Checks
```
attr type CHECK (<condition>)
```

- `<condition>` can be a subquery like `(attr IN (SELECT x FROM y))`
- The condition is checked only during an `INSERT` or `UPDATE`.

### Tuple-Based Checks
- `CHECK (<condition>)` may be added as another element of the schema definition.
- The condition can refer to any attribute of the relation or to other relations/attributes in subqueries.
- Checked whenever a tuple is inserted or updated.

### Assertions
- Assertions are database schema constraints.
- Condition can refer to any relation or attribute in the database schema.
- The `ASSERTION` is checked after every modification to any relation of the database.

```
CREATE ASSERTION <name> CHECK (<condition>);
```

## Views
- A view is a dynamic result of a query over the base relations to produce another relation.
- A view is considered virtual because it does not usually exist in the database but is rather calculated when needed.
- Only the view definition is stored in the database, not the view itself.
- To the user, a view appears just like any other table and can be present in any SQL query where a table is present.
- A view can be queried as if it were a base table. A DBMS maps a query expressed on views onto a query expressed on base relations in compile time.
- By selecting a subset of the database, views hide some data.
- If users can only access the database through views, they cannot see or manipulate the hidden data.

```
CREATE VIEW <name> AS <query>;
```

### Updates through Views
- A view is updatable only if the updates to the view can be propagated to the base relations without ambiguity.
- Views derived from a single relation using selection and projection are updatable.
- Views defined using grouping and aggregate functions are not updatable.
- Views defined on multiple tables using joins are generally not updatable.
	- Only updatable if they include the keys of the base relations.

### Temporary Views
- Complex queries can be easier to write by breaking them into smaller views.
- `WITH` allows the definition of a temporary view, whose definition is only available to the query in which the `WITH` clause occurs.
- Makes the logic simpler to follow and permits a view definition to be used multiple times in a query.

```
WITH ViewName(attr1, attr2) AS
	SELECT attr1, attr2
	FROM Relation1, Relation2
	WHERE condition
SELECT attr1
FROM ViewName
WHERE condition;
```

<!-- /Lecture 5 -->

<!-- Lecture 6 -->

## Triggers
- Attribute-based & tuple-based checks have limited capabilities and assertions are hard to implement efficiently.
- A trigger allows the user to specify when the check occurs.
- At any given point in time, several triggers may be activated. The order of their execution is not decided.
- The execution of a trigger may activate other triggers i.e. a chain reaction of triggers firing.

### Event-Condition-Action
- Triggers are awakened when certain events occur.
- An event can be the execution of an SQL `INSERT`, `DELETE` or `UPDATE` statement as a whole or change to individual tuples made by each statement.
- A trigger can have a precondition which is checked immediately after the event is requested.
- If the condition of the trigger is satisfied, the action associated with the trigger is performed.
	- The action can be one or more SQL statements from `INSERT`, `DELETE`, `UPDATE`, `ROLLBACK`, `SQL/PSM`.

### Trigger Execution
- A trigger can be executed either:
	- `AFTER` the triggering event
	- `BEFORE` the triggering event
	- `INSTEAD OF` the triggering event

#### AFTER Trigger Execution
- Executes entirely after the triggering event has applied its changes to the database.
- Allowed to make changes to the database.
- Can activate other triggers.

#### BEFORE/INSTEAD OF Trigger Execution
- The event is a *request* to the DBMS. It is possible for the DBMS to ignore this request and execute the trigger instead of or before allowing the requested action to occur.
- `BEFORE` executes entirely before the triggering event.
	- `WHEN` condition is tested before the triggering event.
	- Not allowed to modify the database.
	- Can only test the precondition in the `WHEN` clause and accept or abort the triggering transaction.
	- Does not activate other triggers.
- `INSTEAD OF` triggers are mainly used to propagate modifications on a view onto the base tables.

### Trigger Granularity
- A trigger can either be row level or statement level.
- `FOR EACH ROW` indicates row level.
	- Executed once for each modified tuple.
- `FOR EACH STATEMENT` indicates statement level.
	- Statement level triggers are executed once for each SQL statement, regardless of the number of tuples modified.
	- Example: An `UPDATE` statement that does not modify any tuples will still activate a statement level trigger.

### Trigger Syntax
```
/* Row Level */
CREATE [OR REPLACE] TRIGGER triggerName
{AFTER | BEFORE | INSTEAD OF} {INSERT | DELETE | UPDATE} ON Relation
REFERENCING {NEW ROW AS var | OLD ROW AS var}
FOR EACH ROW
WHEN (condition)
{INSERT INTO ... | DELETE FROM ... | UPDATE ... | ROLLBACK};

/* Statement Level */
CREATE [OR REPLACE] TRIGGER triggerName
{AFTER | BEFORE | INSTEAD OF} {INSERT | DELETE | UPDATE} ON Relation
FOR EACH STATEMENT
{INSERT INTO ... | DELETE FROM ... | UPDATE ... | ROLLBACK};
```
```
/* Complete Trigger Syntax */
CREATE [OR REPLACE] TRIGGER triggerName
{AFTER | BEFORE} {INSERT | DELETE | UPDATE [OF attr-list]} ON Relation
[REFERENCING [OLD ROW AS var]
			 [NEW ROW AS var]
			 [OLD TABLE AS var]
			 [NEW TABLE AS var]]
[FOR EACH {ROW | STATEMENT}]
[WHEN (condition)]
[BEGIN]
	statement-list;
[END];
```

<!-- /Lecture 6 -->

<br>
<hr>
<br>

<!-- Lecture 7 -->

## SQL in Server Environment
- So far, the SQL statements have been executed via some sort of terminal onto the DBMS directly. However, in real-world applications, conventional programs have to interact with SQL.
- Embedded SQL in Host Language (e.g. C)
- Connection Tools (e.g. JDBC)
- Code in a Specialised Language Stored in the Database (e.g. PSM)

## Embedded SQL
- SQL statements can be embedded in a host language (e.g. C).
- A preprocessor turns SQL statements into procedure calls that fit with the surrounding host language code.
- All embedded SQL statements begin with `EXEC SQL`, so that the preprocessor can find them easily.

### Shared Variables
- Passing data between SQL and the host language is not straightforward because of the different data models.
- **Shared Variables** are allowed to appear in both, host language statements and SQL statements.
- In SQL, the shared variables must be preceded by a colon.
- In the host language, the shared variables behave like any other variable.

#### Declaring Shared Variables
- Shared variables must be of types that both the host language and SQL can deal with.

```
EXEC SQL BEGIN DECLARE SECTION;
	char varName[size], varName[size];
	float varName;
EXEC SQL END DECLARE SECTION;
```

#### Using Shared Variables
```
void function() {
	/* Declaring Variables */
	
	/* Application Logic */
	
	EXEC SQL INSERT INTO Relation(attr, attr)
	VALUES(:varName, :varName);
```

### SELECT-FROM-WHERE Queries
- Any SQL statement that does not return a result can be embedded in a host language program by preceding it with `EXEC SQL`. Examples: `INSERT`, `DELETE`, `UPDATE` statements.
- However, queries return results that have an impedance mismatch with the host language.

#### Single Row SELECT Statements
- `INTO` keyword and a list of shared variables follows the `SELECT` clause.
- If the result of the query is a single tuple, the tuple's components become values of the shared variables.
- If no tuple or more than one tuple is returned, no assignment is made and the appropriate error code is written into the `SQLSTATE` variable.

```
EXEC SQL SELECT attr
	INTO :sharedVar
	FROM Relation
	WHERE attr = :sharedVar;
```

### SQLSTATE
- `SQLSTATE` is a special variable to connect the host language program with the SQL execution system.
- `SQLSTATE` is an array of five characters.
	- '00000' - No Error Condition,
	- '02000' - No Tuple Found etc.

### Cursors
- A mechanism to retrieve rows one at a time from a relation.
- Declared on any relation or SQL query.
	- **Open** the cursor (position the cursor just before the first row)
	- **Fetch** the next row
	- **Move** the cursor
	- **Close** the cursor

```
/* Cursor Declaration */
EXEC SQL DECLARE <cursor name> CURSOR FOR <query>;

/* Opening & Closing a Cursor */
EXEC SQL OPEN CURSOR <cursor name>;
EXEC SQL CLOSE CURSOR <cursor name>;

/* Get The Next Tuple */
EXEC SQL FETCH <cursor name> INTO <variable(s)>;
```
```
#define NOT_FOUND !(strcmp(SQLSTATE,"02000"))

EXEC SQL OPEN CURSOR cursorName;

while(1) {
	EXEC SQL FETCH cursorName INTO :sharedVar, :sharedVar;
	if(NOT_FOUND) break;
	
	/* Application Logic */
}

EXEC SQL CLOSE CURSOR cursorName;
```

#### Modification by Cursor
- It is also possible to update or delete the current tuple using a cursor.

```
EXEC SQL DELETE FROM Relation WHERE CURRENT OF <cursor name>;
```

### Dynamic SQL
- Dynamic SQL allows queries to be read and executed at run-time i.e. SQL statements are unknown at compile time.
- The host language program can instruct the SQL system to take a character string and turn it into an executable SQL statement.

```
/* Preparing a Query */
EXEC SQL PREPARE <query name> FROM <text of the query>;

/* Executing the Query */
EXEC SQL EXECUTE <query name>;

/* Combined Step */
EXEC SQL EXECUTE IMMEDIATE <text of the query>;
```
```
EXEC SQL BEGIN DECLARE SECTION;
	char *query;
EXEC SQL END DECLARE SECTION;

/* Create Query in C */

EXEC SQL PREPARE q FROM :query;
EXEC SQL EXECUTE q;
```

<!-- /Lecture 7 -->

<!-- Lecture 8 -->

## Persistent, Stored Modules
- When SQL statements are issued from a remote application, the query results need to be transferred and knowledge of the database schema is required beforehand.
- Thus, a solution is to run application logic directly at the database server.
	- Amount of data transfer between DB server and client is minimised.
	- The power of DBMS is utilised.
	- The code is reusable among different users.
	- Application programmers don't need to know the database schema.

### PSM
- Stored procedures & stored functions.
- Allows us to store procedures/functions as database schema elements.
- A mixture of conventional statements (if, while etc.) and SQL.

### Stored Procedure/Function
- A program that is executed through a single SQL statement that can be executed in a database server.
- Application logic can be performed directly at the server, without having to transfer results to the clients at all.

### PSM VS Views
- Views are a way to register **queries** inside the DBMS.
- Stored procedures & functions are a way to register **code** inside the DBMS.

### Basic PSM Form
```
CREATE PROCEDURE <name> (<parameter list>)
	<optional local declarations>
	<body>;

CREATE FUNCTION <name> (<parameter list>) RETURNS <type>
	<optional local declarations>
	<body>;
```

#### Parameters of PSM
- `MODE NAME TYPE` triples.
- Modes:
	- `IN` = procedure uses value, does not change value (default)
	- `OUT` = procedure changes value, does not use value
	- `INOUT` = both
- Functions can only have `IN`-mode parameters. The only way to obtain information from a function is through the return value.

#### PSM Statements
##### DECLARE \<name> \<type>;
- Declares a local variable with the given name and type.
- Must precede executable statements in a function or procedure body.

##### SET \<variable> = \<expression>;
- Assigns a value to a variable.
- The expression may be a query that returns a single value.

##### RETURN \<expression>;
- Can only appear in a function.
- Does not terminate a function.

##### BEGIN...END;
- For groups of statements.
- Statements are separated inside using semicolons.

##### Statement Labels
- Label a statement by prefixing it with a name and a colon.

##### IF-ELSE Statements
```
IF <condition> THEN
	<statement(s)>
END IF;

IF...THEN...ELSE...END IF;

IF...THEN..ELSEIF...ELSEIF...ELSE...END IF;
```

##### LOOP
```
loopName:	LOOP
				<statement(s)>
				LEAVE loopName;
			END LOOP;
```

### Invoking a Procedure
- Use the SQL/PSM statement `CALL`, with the name of the desired procedure and appropriate arguments.
	- From host language program. *Parameters have to be shared variables.*
	- As a statement of another PSM function or procedure.
	- As a standalone SQL command issued through the generic SQL interface.

### Invoking a Function
- A function cannot be invoked in embedded SQL.
- However, a function can be invoked standalone or from other procedures, functions and triggers.
- In addition to the above, functions can also be used inside `SELECT-FROM-WHERE` statements in the `WHERE` & `HAVING` clauses or the projection list.

```
SELECT *
FROM Relation
WHERE attr = function(parameter);
```

### Queries
- General `SELECT-FROM-WHERE` queries are not permitted in PSM, however:
	- Queries producing one value can be the expression in an assignment.
	- Single-row `SELECT...INTO`.
	- Cursors.

```
SET varName = (<query>);
SELECT attr INTO varName FROM Relation WHERE condition;
```
```
DECLARE NotFound CONDITION FOR SQLSTATE '02000';
DECLARE cursorName CURSOR FOR (<query);
...
OPEN cursorName;
loopResults:	LOOP
					FETCH cursorName INTO varName, varName;
					IF NotFound THEN LEAVE loopResults END IF;
					<statement(s)>
				END LOOP;
CLOSE cursorName;
```

## Call-Level Interface
- Write ordinary host language code using a library of functions that allows us to connect and pass SQL statements to the database.
- Example: Java Database Connectivity (JDBC)

```
import java.sql.*; // make the JDBC class available
...
Class.forName(<driver name>); // load a 'driver' for the database system
...
Connection myCon = DriverManager.getConnection(<URL>, <user name>, <password>); // returns an object of class Connection
```

### Statements
- SQL statements can be passed to a connection.
- `Statement`: An object that can accept a string that is an SQL statement and can execute such a string.
- `PreparedStatement`: An object that has an associated SQL statement that is ready to execute.

#### Executing SQL Statements
- JDBC distinguishes queries from modifications, which it calls "updates".
- `Statement` and `PreparedStatement` each have methods `executeQuery()` and `executeUpdate()`.

##### executeQuery()
- `executeQuery(Q)`: Takes in a query statement and returns a ResultSet object.
- `executeQuery()`: Applied to `PreparedStatement` and returns a `ResultSet` object.

```
Statement stat1 = myCon.createStatement();
ResultSet res = stat1.executeQuery("SELECT attr FROM Relation WHERE condition");
```
```
PreparedStatement stat2 = myCon.createStatement("SELECT attr FROM Relation WHERE condition");
ResultSet res = stat2.executeQuery();
```

##### executeUpdate()
- `executeUpdate(U)`: Takes a non-query statement and executes it.
- `executeUpdate()`: Applied to `PreparedStatement`.

```
stat1.executeUpdate("INSERT INTO Relation VALUES (x, y)");
```

#### ResultSet
- An object of type `ResultSet` is something like a cursor.
- `.next()`: Advances the cursor to the next tuple. If there are no more tuples, `.next()` returns `FALSE`.
- `.getX(i)`: `X` is some type and `i` is the component number. The method returns the value of that component, which must have type `X`.

```
while(res.next()) {
	String var1 = res.getString(1);
	float var2 = res.getFloat(2);
}
```

<!-- \Lecture 8 -->
