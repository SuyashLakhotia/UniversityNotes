# Artificial Intelligence Part II

## Logical Agents
### The Knowledge-Based Approach
- Agents that *know*
	- achieve competence by being told new knowledge or by learning.
	- achieve adaptability by updating their knowledge.
	- *Knowledge Representation*
- Agents that *reason*
	- use knowledge to deduce the course of action.
	- *Knowledge Inference*

### Knowledge-Based Agents
- Knowledge Base (KB): Set of Sentences (Sentence = Representation of a Fact/Rule).
- Adding & Querying Knowledge
	- *TELL*: add a sentence to the KB
	- *ASK*: retrieve knowledge from the KB
		- Answers must *follow* from what has been *TELL*-ed.
- Inference Mechanism: Determines what follows from the KB.
- Knowledge Based System
	- States: Instances of the KB
	- Operators: Add/Infer a New Sentence
	- Goal: Answer a Query

### Levels of Knowledge
- Epistemological Level: Declarative description of knowledge.
	- e.g. facts: "there is smoke", rules: "if there is smoke, there is fire"
- Logical Level: Logical encoding of knowledge (into sentences).
	- e.g. facts: Smoke, rules: Implies(Smoke, Fire)
- Implementation Level: Physical representation of knowledge.
	- e.g. Strings, 2-D Arrays etc.

### Knowledge Representation
- The KB (set of sentences) needs to be expressed in a computer-tractable form.
- The KR language must be expressive, concise, unambiguous, context-independent & effective.
- KR Language split into:
	- Syntax - a set of rules for writing sentences.
	- Semantics - a set of rules (or constraints) for relating sentences to real-world facts.

### Reasoning & Logic
- Logic = Representation + Inference
- Reasoning - Construction of new sentences from existing ones.
- Entailment - Generate sentences that are necessarily true, given that the existing sentences are true. KB &#8872; &alpha;.

#### Inference:
- *Inference (reasoning) is the process by which conclusions are reached.*
- Logical inference (deduction) is the process that implements entailment between sentences.
- Properties of Inference:
	- Soundness: An inference algorithm is sound if it derives only sentences that are entailed by the KB.
	- Completeness: An inference algorithm is complete if it can derive any sentence that is entailed by the KB.
	- Proof Theory: A set of rules for deducing the entailments of sentences.
- **Valid** Sentence (Tautology): iff TRUE under all possible interpretations in all possible worlds. e.g. S &or; &not;S.
- **Satisfiable** Sentence: iff there is some interpretation in some world for which it is TRUE. e.g. S &and; &not;S is unsatisfiable.

**Deductive Inference:**

X &rArr; Y, X &#8866; Y

- Sound.
- *Modus Ponens*.

**Inductive Inference:**

X &rArr; Y, Y &#8866; X

- Not sound.
- Generalisation.

#### Different Logics
- **Propositional Logic:**
	- Symbols represent propositions (facts).
	- Boolean connectives combine symbols.
- **First-Order Logic:**
	- Objects and predicates (unary, binary or n-ary) representing properties of and relations between objects.
	- Variables, boolean connectives and quantifiers.
- **Temporal Logic:**
	- World ordered by a set of time points/intervals.
- **Probabilistic & Fuzzy Logic:**
	- Degrees of belief and truth in sentences.
	- e.g. "Washington is a large city" with truth degree 0.6.

## Propositional Logic
- **Symbols:**
	- Logical Constants: TRUE, FALSE
	- Propositional Symbols: P, Q, R etc.
	- Logical Connectives: &and;, &or;, &not;, &not;, &rArr;, &hArr;
	- Parentheses: ()
- **Sentences:**
	- Atomic sentences combined with connectives or wrapped in parentheses.

### Logical Connectives
- Conjunction: &and;
- Disjunction: &or;
- Implication: &rArr;
- Equivalence: &hArr;
- Negation: &not;

*Precedence (from highest to lowest)*: &not;, &and;, &or;, &rArr;, &hArr;

### Validity & Inference
- A sentence can be tested for validation using truth-tables and checking all possible configurations.
- Sound inference can be checked by building a truth-table for *Premises &rArr; Conclusion*.

### Inference Rules
**Implication-Elimination or** ***Modus Ponens*****:**
> &alpha; &rArr; &beta;,&nbsp; &alpha; &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &beta;

**And-Elimination:**
> &alpha;<sub>1</sub> &and; &alpha;<sub>2</sub> &and; &alpha;<sub>3</sub> &and; ... &alpha;<sub>n</sub> &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha;<sub>i</sub>

**And-Introduction:**
> &alpha;<sub>1</sub>, &alpha;<sub>2</sub>, &alpha;<sub>3</sub>, ... &alpha;<sub>n</sub> &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha;<sub>1</sub> &and; &alpha;<sub>2</sub> &and; &alpha;<sub>3</sub> &and; ... &alpha;<sub>n</sub>

**Or-Introduction:**
> &alpha;<sub>i</sub> &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha;<sub>1</sub> &or; &alpha;<sub>2</sub> &or; &alpha;<sub>3</sub> &or; ... &alpha;<sub>n</sub>

**Double-Negation-Elimination:**
> &not;&not;&alpha; &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha;

**Unit Resolution:**
> &alpha; &or; &beta;,&nbsp; &not;&beta; &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha;

**Disjunctive Resolution:**
> &alpha; &or; &beta;,&nbsp; &not;&beta; &or; &gamma; &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &alpha; &or; &gamma;

**Implicative Resolution:**
> &not;&alpha; &rArr; &beta;,&nbsp; &beta; &rArr; &gamma; &nbsp;&nbsp; &#8872; &nbsp;&nbsp; &not;&alpha; &rArr; &gamma;

### Equivalence Rules
**Associativity:**
> &alpha; &and; (&beta; &and; &gamma;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; (&alpha; &and; &beta;) &and; &gamma;

> &alpha; &or; (&beta; &or; &gamma;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; (&alpha; &or; &beta;) &or; &gamma;

**Distributivity:**
> &alpha; &and; (&beta; &or; &gamma;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; (&alpha; &and; &beta;) &or; (&alpha; &and; &gamma;)

> &alpha; &or; (&beta; &and; &gamma;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; (&alpha; &or; &beta;) &and; (&alpha; &or; &gamma;)

**De Morgan's Law:**
> &not;(&alpha; &or; &beta;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; &not;&alpha; &and; &not;&beta;

> &not;(&alpha; &and; &beta;) &nbsp;&nbsp; &hArr; &nbsp;&nbsp; &not;&alpha; &or; &not;&beta;

**Conjunctive Normal Form:**
> A &rArr; B &nbsp;&nbsp; &hArr; &nbsp;&nbsp; &not;A &or; B

> A &hArr; B &nbsp;&nbsp; &hArr; &nbsp;&nbsp; (A &or; &not;B) &and; (&not;A &or; B)

### Complexity of Inference
- Proof by truth-table is complete but has exponential time complexity.
- Inferring new sentences using various inference rules and proving thus.
	- **Horn Clauses:** A disjunction of literals with at most one unnegated literal.
		- Definite Clause:
			- &not;P &or; &not;Q &or; ... &or; &not;T &or; U
			- P &and; Q &and; ... &and; T &rArr; U
		- Fact: U
- Using a logic programming language like Prolog, which uses horn clauses and Modus Ponens. Inference can be achieved in polynomial time complexity.

### Limits of Propositional Logic
Propositional logic is a **weak logic**.

- Too many propositions to TELL the KB. Results in increased time complexity of inference.
- Handling changes in the environment is difficult.

## First Order Logic
- In first-order logic, the world is seen as objects with properties (about each object) and relations (between objects).
- **Sentences** are built from quantifiers, predicate symbols and terms.
- **Constant Symbols** refer to the *name* of the particular objects. e.g. `John`.
- **Predicate Symbols** refer to particular relations on objects. e.g. `Brother(John, Richard)` -> T or F.
- **Function Symbols** refer to functional relations on objects. e.g. `BrotherOf(John)` -> a person.
- **Variables** refer to any object of the world and can be substituted by a constant symbol. e.g. x, y.
- **Terms** are logical expressions referring to objects that may include function symbols, constant symbols and variables. e.g. `LeftLegOf(John)` to refer to the leg without naming it.

### Sentences in FOL
- **Atomic Sentences**
	- state facts using terms and predicate symbols
		- e.g. `Brother(Richard, John)`
	- can have complex terms as arguments
		- e.g. `Married(FatherOf(John), MotherOf(Richard))`
	- have a truth value
- **Complex Sentences** combine sentences with connectives identical to propositional logic.

### Quantifiers
#### Universal Quantifier &forall;
- Express properties about a collection of objects.
- Applies to every object in the collection.
- e.g. &forall;x, King(x) &rArr; Mortal(x)
- &rArr; is the natural connective to use with &forall;.

#### Existential Quantifier &exist;
- Express properties of one or more particular objects in a collection.
- e.g. &exist;x, P(x) &and; Q(x)
- &and; is the natural connective to use with &exist;.

#### Connections between Quantifiers
> &forall;x P(x) &hArr; &not;&exist;x &not;P(x)

> &forall;x &not;P(x) &hArr; &not;&exist;x P(x)

> &not;&forall;x P(x) &hArr; &exist;x &not;P(x)

> &not;&forall;x &not;P(x) &hArr; &exist;x P(x)

#### Notes
- Remember that the semantics depends on the quantifiers ordering if more than one is used.

### Equality Predicate Symbol
- States that two terms refer to the same object.
	- e.g. Father(John) = Henry
	- e.g. =(Father(John), Henry)
- Useful to define properties.

### Using First-Order Logic
- The *knowledge domain* is the part of the world we want to express knowledge about.
- The **facts** and **rules** are fed into the KB.
- TELLing the KB:
	- Assertion: add a sentence to the KB
	- e.g. TELL(KB, &forall;x,y MotherOf(x)=y &hArr; Parent(x,y) &and; Female(y))
- ASKing the KB:
	- Query: retrieve/infer a sentence from the KB
	- Yes/No Answer
		- e.g. ASK(KB, Grandparent(Elizabeth, William))
	- Binding List or *Substitution*
		- e.g. ASK(KB, &exist;x Child(William, x)) yields {x / Charles}
- Knowledge-based agents need to use goals in conjunction with knowledge to make plans.

## Inference in First-Order Logic
### Inference Rules w/ Quantifiers
#### Substitutions
- SUBST(&theta;, &alpha;): binding list &theta; is applied to a sentence &alpha;.
	- e.g. SUBST({x / John, y / Richard}, Brother(x, y)) = Brother(John, Richard)

#### Additional Inference Rules
**Universal Elimination:**
> &forall;x &alpha; &#8872; SUBST({x / g}, &alpha;) &nbsp;&nbsp;&nbsp; where `g` is a ground term

**Existential Elimination:**
> &exist;x &alpha; &#8872; SUBST({x / K}, &alpha;) &nbsp;&nbsp;&nbsp; where `K` is a Skolem constant

**Existential Introduction:**
> &alpha; &#8872; &exist;x SUBST({x / g}, &alpha;) &nbsp;&nbsp;&nbsp; where `g` is a ground term

#### Skolemization
Existential quantifiers (&exist;) can be eliminated by replacing the corresponding variable with a Skolem function. The arguments of a Skolem function include all the universally quantified variables that are bound by universal quantifiers whose scopes include the scope of the existential quantifier being eliminated. If a Skolem function has no arguments, it's just a Skolem constant.

- &forall;x &exist;y P(x, y) becomes &forall;x P(x, S(x))
- &exist;y &forall;x P(x, y) becomes &forall;x P(x, S)
- &exist;y P(y) becomes P(S)

### Unification
- Find a substitution that makes two atomic sentences alike.
- i.e. UNIFY(&alpha;, &beta;) = &theta; where SUBST(&theta;, &alpha;) = SUBST(&theta;, &beta;)

#### Most General Unifier (MGU)
- Unifying yields an infinite number of substitutions.
- The MGU is a unifier that makes the least commitments about the bindings of the variables. UNIFY always returns the MGU.

#### Composition of Substitutions
> SUBST(Compose(&theta;<sub>1</sub>, &theta;<sub>2</sub>), &alpha;) = SUBST(&theta;<sub>2</sub>, SUBST(&theta;<sub>1</sub>, &alpha;)

### Proof as a Search Problem
- Proof procedure is a sequence of inference rules applied to the KB.
- Initial State i.e. KB → Operators i.e. Inference Rules → Goal State i.e. KB w/ Goal
- Branching factor increases as the KB grows.

### Generalised Modus Ponens
Universal-Elimination + And-Introduction + Modus Ponens

**Example:**<br>
Missile(M1),<br>
Owns(Nono, M1),<br>
&forall;x Missile(x) &and; Owns(Nono, x) &rArr; Sells(West, Nono, x)<br>
&#8872; Sells(West, Nono, M1)

> &gamma;<sub>1</sub>, &gamma;<sub>2</sub>,...,&gamma;<sub>n</sub>, (&alpha;<sub>1</sub> &and; &alpha;<sub>2</sub> &and; ... &and; &alpha;<sub>n</sub> &rArr; &beta;) &#8872; SUBST(&theta;, &beta;)
> where &forall;i SUBST(&theta;, &gamma;<sub>i</sub>) = SUBST(&theta;, &alpha;<sub>i</sub>)

Every fact (&gamma;<sub>i</sub>) must have a corresponding antecedent (&alpha;<sub>i</sub>) in the rule for GMP.

### Forward & Backward Chaining
- **Forward Chaining (data-driven) -** Start with the KB and generate new sentences given a particular event (&alpha;). KB, &alpha; &#8872; ?.
- **Backward Chaining (goal-driven) -** Start with a sentence not in the KB and attempt to establish its premises. KB &#8872; &beta;?

#### Forward Chaining
**Idea:** Inferring new consequences.

**Pseudo Algorithm**

1. TELLing a new sentence &alpha;.
2. If &alpha; is already in the KB, do nothing.
3. Find all the implications that have &alpha; as a premise, i.e. &alpha; &and; &alpha;<sub>1</sub> &and; ... &and; &alpha;<sub>n</sub> &rArr; &beta;.
4. Then, if all the other premises &alpha;<sub>i</sub> are known under some MGU &theta;, infer the conclusion &beta; under &theta;.
5. If some premises &alpha;<sub>i</sub> can be matched several ways, then infer each corresponding conclusion.

**Using Forward Chaining**

1. Given a KB, derive all the facts and rules.
2. If there are facts with &exist;, skolemize them and derive the new facts.
3. Use GMP to satisfy the rules and derive new facts recursively until the goal is reached.

#### Backward Chaining
**Idea:** Checking for causes.

**Pseudo Algorithm**

1. ASKing a query &beta;.
2. If &beta; is already in the KB, proof immediate.
3. Else, find all implications that have &beta; as a conclusion, i.e. &alpha;<sub>1</sub> &and; &alpha;<sub>2</sub> &and; ... &and; &alpha;<sub>n</sub> &rArr; &beta;.
4. Then, try and establish all the premises &alpha;<sub>i</sub> and infer &beta;.

**Using Backward Chaining**

1. Given a KB, derive all the facts and rules.
2. If there are facts with &exist;, skolemize them and derive the new facts.
3. Derive a unifying list that satisfies the goal &beta;.

### Generalised Resolution
- **Conjunctive Normal Form (CNF):** All sentences are a disjunction of literals, negated or not. A &or; B &or; ... &or; C.
- **Implicative Normal Form (INF):** All sentences are implications of non-negated literals, with a conjunction of premises and a disjunction of consequents. &alpha;<sub>1</sub> &and; ... &and; &alpha;<sub>m</sub> &rArr; &beta;<sub>1</sub> &or; ... &or; &beta;<sub>n</sub>.
- **Conjunctive Knowledge Base:** All sentences are joined in one big, implicit conjunction.

#### Conversion from CNF to INF
> A &or; &not;B &or; &not;C &or; D &or; &not;E &nbsp;&nbsp; &hArr; &nbsp;&nbsp; B &and; C &and; E &rArr; A &or; B

#### Converting FOL to Normal Form
1. Eliminate implications by converting them to CNF.
2. Reduce the scope of negations using De Morgan's laws. e.g. &not;(A &or; B) becomes &not;A &and; &not;B.
3. Standardise sentences apart by renaming variables.
4. Move quantifiers to the left.
5. Remove existential quantifiers using skolemization.
6. Drop the universal quantifiers.
7. Distribute conjunctions (&and;) over disjunctions (&or;). e.g. (P &and; Q) &or; R becomes (P &or; R) &and; (Q &and; R).
8. Flatten nested conjunctions and disjunctions. e.g. (P &or; Q) &or; R becomes P &or; Q &or; R.
9. Convert disjunctions back to implications.

#### Refutation
- Resolution by refutation is proof by contradiction.
	- To prove P to be true, assume it to be false and prove a contradiction.
- Resolution by refutation is simple, sound and complete.
- Resolution with refutation is guaranteed to find a solution.

##### Refutation Strategies
- Unit Preference: Favour short sentences (even unit clauses, if possible).
- Set of Support: Define a subset of the KB and use those sentences only.
- Input Resolution: Combine KB sentences to some inferred sentence.
- Subsumption: Eliminate all sentences subsumed (more specific than) existing sentences in the KB. e.g. P(A) is not needed if P(x) is present.

### Generalised Modus Ponens vs. Generalised Resolution
- GMP is not complete while GR is complete.
- GMP uses unification to provide a powerful inference rule while GR uses refutation to prove.
- GMP uses sentences in Horn form while GR uses sentences in either CNF or INF.
- GMP can be either data-driven or goal-oriented.
- GR can use several strategies (heuristics) to improve efficiency and reduce the size of the search space.

## Logical Reasoning Systems
### Forward Chaining Production Systems
- **Forward Chaining System**
	- All clauses represented as Horn clauses.
	- Assertions instead of queries. Inference generates new knowledge until a criterion is met.
	- Appropriate for condition-action rules.
	- Theorem provers too generic and can result in huge branching factor.
- **Typical Features**
	- Rule Memory (KB) - Sentences, Rules
	- Working Memory (WM) - Positive Literals w/ No Variables, Facts
	- 3-Step Inference (Matching, Conflict Resolution, Acting)

#### Conflict Resolution
- Which of the matching rules should be fired?
- **None:** Execute systematically all rules.
- **No duplication:** Do not execute the same rule on the same arguments twice.
- **Recency:** Favour rules that refer to elements recently created in the WM.
- **Specificity:** Favour rules that are more specific i.e. have more constraints.
- **Operation Priority:** Favour rules that yield high-priority actions.

#### Using Production Systems
- Modular Systems - Inference Engine + Domain Specific KB
- Expert Systems
- Cognitive Architectures - Models human reasoning.

## Building Knowledge-Based Agents
- **Knowledge Representation:** Logic-based (propositional logic, FOL etc.) or Graphic-based (frames, semantic networks, etc.).
- **Knowledge Inference (Reasoning):** Inference Rules, Handling Changes, Handling Uncertainty.
- **Knowledge Engineering:** Acquiring Knowledge & Building the KB.

### Acquiring Knowledge
- Domain Expert
	- Knows about the domain.
	- Knows nothing about the knowledge-based system or logic.
- Knowledge Engineer
	- Knows little or nothing about the domain.
	- Knows how to use knowledge representation language.
- Knowledge Acquisition
	- via interviews, examples etc.
	- Build a clear, effective & correct KB.
	- Computational tools available to extract a KB from data.

### Building the KB
- Decide what to talk about. What are the important concepts/relations?
- Decide what vocabulary to use. Translate important domain concepts into logical names.
- Encode general domain knowledge. Translate known relations and rules into logical axioms.
- Encode specific domain knowledge. Translate known facts into logical atomic sentences.