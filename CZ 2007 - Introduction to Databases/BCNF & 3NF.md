# BCNF & 3NF

## Basics
- A trivial FD is one where all the attributes in the RHS appear in the LHS.

## BCNF
### Condition
A table R is in BCNF iff for every non-trivial FD on R, the LHS of the FD is a superkey of R.

### BCNF Decomposition
1. Find the keys of R.
2. Identify the FD, X → Y, that violates the BCNF condition.
3. Compute the closure of the LHS of this FD i.e. {X}<sup>+</sup>.
4. Decompose R into R1 & R2 where R1 contains all the attributes in {X}<sup>+</sup> and R2 contains X and all the attributes not in {X}<sup>+</sup>.
5. Repeat on R1 & R2.

*Note: When repeating the steps for R1 & R2, if X* ***or*** *Y from an original FD do not appear in the decomposed tables, use closures to derive new FDs.*

### Notes
- BCNF decomposition may not be unique.
- If a table has two attributes, it must be in BCNF.
- The original table can always be constructed from the decomposed tables. Lossless Join.
- BCNF decomposition may not preserve all functional dependencies.

## 3NF
### Condition
A table R is in 3NF iff for every non-trivial FD on R, either:

- the LHS of the FD is a superkey of R or,
- each attribute in the RHS is either contained in a key or in the LHS

### 3NF Decomposition
1. Derive a ***minimal basis*** of R.
2. In the minimal basis, combine the FDs whose LHS are the same.
3. Create a table for each of these FDs.
4. If none of the tables contain a key of R, create a table that contains the key.
5. Remove redundant tables, if any.

#### Minimal Basis
1. For any FD in the minimal basis, its RHS must have only one attribute.
2. No FD in the minimal basis must be redundant i.e. it cannot be derived from other FDs present in the minimal basis.
3. For each FD in the minimal basis, none of the attributes in the LHS must be redundant.

### Notes
- For a given set of FDs, the minimal basis may not be unique. Thus, a different minimal basis may lead to a different 3NF decomposition.
- 3NF decomposition always preserves all FDs. *See Step 3 of 3NF decomposition.*

## BCNF vs 3NF
- BCNF is stricter than 3NF.
	- A table in BCNF is always in 3NF, but not vice-versa.
	- A table that violates 3NF always violates BCNF, but not vice-versa.