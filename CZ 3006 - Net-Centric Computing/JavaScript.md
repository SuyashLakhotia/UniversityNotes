# JavaScript

## Basics
- JavaScript scripts are embedded in HTML documents. A browser uses its JavaScript interpreter to *execute* the script.

```
<script type="text/JavaScript">
	--- JavaScript Script ---
</script>
```
```
<script type="text/JavaScript" src="myScript.js"></script>
```
```
<!--
	--- JavaScript Script ---
//-->
```

## General Syntax
- Identifiers begin with a letter or underscore, followed by any number of letters, underscores & digits.
- Variable names are case sensitive.
- Comments: `//` and `/*...*/`.

## Primitives, Operations & Expressions
- Values in JS are either primitives or objects.
- JS has five primitive types &mdash; Number, String, Boolean, Undefined and Null.
	- **Number:** All numeric literals. Stored in double-precision floating point.
	- **String:** Delimited by `'` or `"`. Can include escape sequences using `\`.
	- **Boolean:** `true` or `false`.
	- **Undefined:** Declared without assigning a value.
	- **Null:** Undeclared.

- JS is **dynamically typed** i.e. any variable can be used for anything.

```js
var today = 0;
today = "Monday";
today = false;
```

- **Operators:**
	- Numeric Operators: `++`, `--`, `+`, `-`, `*`, `/`, `%`
	- String Concatenation Operator: `+`
	- Coercion:
		- `7 * "3"` (String to Number)
		- `"August" + 1977` (Number to String)

## Objects
- JS is **NOT** an object-oriented programming language.
	- It is an object-based language.
	- JS does not have classes.
	- Without classes, JS does not support class-based inheritance.
- JS Objects
	- JS objects are collections of properties, which are like the members of classes in Java and C++.
		- Each property is either a data property or a method.
	- All JS objects are accessed through references.

**The Number Object**

```js
var price = 427;
var strPrice = price.toString();
```

**The String Object**

```js
var str = "Hello";

str.length;				// 5
str.charAt(2);			// 'l'
str.indexOf('e');		// 1
str.substring(1, 3);	// 'ell'
str.toLowerCase();		// 'hello'
str.toUpperCase();		// 'HELLO'
```

**The Math Object**

```js
Math.floor(x);
Math.round(x);
Math.max(x, y);
Math.min(x, y);
Math.pow(x, y);
Math.sin(x);
Math.cos(x);
```

## Screen Output
- The model for the browser display window is the `Window` object.
	- The `Window` object provides the largest enclosing referencing environment for JS scripts.
	- The `Window` object has two properties, `document` and `window`, which refer to the `Document` and `Window` objects respectively.
	- The `Document` object represents the displayed XHTML document.

### Dialog Boxes
- The `Window` object has three methods for creating dialog boxes:

```js
alert("Hey!");
confirm("Do you want to continue?");			// returns boolean
prompt("What is your name?", "Type name here");	// returns input
```

### Writing to Document
- The `Document` object has a method, `write`, which dynamically creates content.```js
document.write("<p>Answer: " + result + "</p>");
```

## Control Statements
```js
if (control expression) {
	// statement(s)
} else if (control expression) {
	// statement(s)
} else {
	// statement(s)
}

switch (expression) {
	case value1:
		// statement(s)
	case value2:
		// statement(s)
	default:
		// statement(s)
}

for (init expression; control expression; increment expression) {
	// statement(s)
}

while (control expression) {
	// statement(s)
}

do {
	// statement(s)
} while (control expression)
```

### Control Expressions
- Relational Expressions:
	- `==`, `!=`, `<`, `>`, `<=`, `>=`
	- `===` and `!==` do the same as `==` & `!==` but no coercions are done.
- Compound Expressions: `&&`, `||`, `!`

```js
"3" == 3	// true
"3" === 3	// false
```

## Object Creation & Modification
- Objects can be created with `new` expression.
	- The most basic object can be made with the `Object` constructor.
	- This new object has no properties &mdash; a blank object.

```js
var myAirplane = new Object();
myAirplane.make = "Boeing";
myAirplane.model = "747";
myAirplane.engine = new Object(); // nested object
myAirplane.engine.make = "Rolls-Royce";
```

- Properties can be accessed by dot notation or array notation.

```js
var property1 = myAirplane.model;
var property2 = myAirplane["model"];
```

- Properties of an object can be iterated through using a loop statement.

```js
for (var prop in myAirplane) {
	console.log(myAirplane[prop]);
}
```

- A property can be deleted with `delete`.

```js
delete myAirplane.model;
```

## Arrays
- Arrays are objects with special functionality.
- Array elements can be primitive values or references to other objects.
- Array elements need not have the same type.

```js
var myList = new Array(24, "bread", true);
var myList2 = [24, "bread", true];
var myList3 = new Array(100);	// creates a new array of length 100
```

- The length of an array is dynamic.

```js
var myList = new Array(24, "bread", true);
myList.length;	// 3
myList[122] = "beat";
myList.length;	// 123
```

### Array Methods
```js
var myList = [3, 4, 1, 7];

myList.join("; ");		// "3; 4; 1; 7"
myList.reverse();		// [7, 1, 4, 3]
myList.sort();			// [1, 3, 4, 7]
myList.concat(5, 6);	// [3, 4, 1, 7, 5, 6]
myList.slice(0, 3);		// [3, 4, 1]
myList.toString();		// "3, 4, 1, 7"
```

## Functions
```js
/* Function Definition */
function funcName(param1, param2) {
	// function body
}
```

- Function definitions are placed in the head of an XHTML document.

- Functions are objects, hence, variables that reference them can be treated the same.

```js
funcAlias = funcName;
funcAlias(); // does the same thing as funcName();
```

**Variable Scope**

- Variables explicitly declared inside a function have local scope.
- Variables explicitly declared outside functions or implicitly declared have global scope.

**Parameters**

- Parameters are passed by value, resulting in pass-by-value semantics for primitives and pass-by-reference semantics for objects (since references to objects are passed).

### Constructor
- Constructors are special methods that create and initialise the properties for newly created objects.
- The function name should be the same as the object being created.

```js
function plane(newMake, newModel, newYear) {
	this.make = newMake;
	this.model = newModel;
	this.year = newYear;
}

myPlane = new plane("Airbus", "A380", "2014");
```

- Constructors can also have method properties.

```js
function editPlaneYear(newYear) {
	this.year = newYear;
}

function plane(newMake, newModel, newYear) {
	...
	this.editYear = editPlaneYear;
}
```

## Pattern Matching
### Patterns
- Patterns are delimited with slashes &mdash; `/`.
- There are two categories of characters in patterns:
	- **Normal Characters** (match themselves)
	- **Metacharacters:** \, |, (), [], {}, ^, $, *, +, ?, .
		- A metacharacter is treated like a normal character if it is preceded by a `\`.

- `.`: Matches any character except newline. e.g. /snow./ matches "snowy", "snowe", "snow.".
- `[]`: Defines a set of characters, any one of which matches. e.g. `[abcd]`, `[a-z]`.
	- `[^0-9]`: Means the opposite.
	- `\d` = `[0-9]`
	- `\D` = `[^0-9]`
	- `\w` = `[A-Za-z_0-9]`
	- `\W` = `[^A-Za-z_0-9]`
	- `\s` = `[\r\t\n\f]`
	- `\S` = `[^\r\t\n\f]`
- `{}`: Quantifiers in braces.
	- `{n}`: Exactly n repetitions of the preceding character.
	- `{m,}`: At least m repetitions of the preceding character.
	- `{m, n}`: At least m but not more than n repetitions of the preceding character.
- Other Quantifiers:
	- `*`: Zero or more repetitions of the preceding character.
	- `+`: One or more repetitions of the preceding character.
	- `?`: Zero or one of the preceding character.
- `^` & `$`: Anchors. The pattern can be forced to match only at the beginning with `^` and at the end with `$`.
	- e.g. /^Lee/ matches "Lee Ann" but not "Mary Lee Ann".
	- e.g. /Lee$/ matches "Ann Lee" but not "Ann Lee Kim".

### Pattern Matching Methods
- `.search(pattern)` returns the position in the String object where the pattern is matched. Returns -1 if there is no match.

```js
var str = "Hello, world";
var pos = str.search(/orl/); // 8
```

- `.replace(pattern, string)` finds a substring that matches the pattern and replaces it with the string.

```js
var str = "rabbits are rabid";
str.replace(/rab/, "tim");	// "timbits are rabid"
str.replace(/rab/g, "tim");	// "timbits are timid"
```

- `.match(pattern)` returns an array of results of the pattern-matching operation.

```js
var str = "abcdc";
str.match(/[bc]/);	// "b"
str.match(/[bc]/g);	// ["b", "c", "c"]
```

- `.split(parameter)` splits the string into substrings and returns them in an array based on the given string or pattern.

```js
var str = "grapes:apples:oranges";
str.split(":");	// ["grapes", "apples", "oranges"]
```

# JavaScript & HTML
## The Document Object Model
- The **Document Object Model (DOM)** is an abstract model that defines the interface between HTML documents and application programs.
- A language that supports the DOM must have a binding to the DOM constructs.
	- A correspondence between constructs in the language and elements in the DOM.
	- In JavaScript:
		- **elements &rArr; objects**
		- **element attributes &rArr; properties**
- Elements in the DOM have a tree-like structure.

## Accessing HTML Elements
- The elements of a HTML document have corresponding objects that are visible to an embedded JavaScript script.
- Every `Document` object has:
	- `forms`: An array of references to the forms in the document.
		- Each `forms` array element has an `elements` array as a property, which has references to the form's elements.
	- Other property arrays referring to anchors, links and images.

### Ways to Access Form Elements
```HTML
<form action="" name="myForm">
	<input type="button" name="pushMe" id="pushMe">
</form>
```

**DOM Address**

```js
document.forms[0].elements[0]
```

- The document can change. Thus, the address is not always constant.

**Element Names**

```js
document.myForm.pushMe
```

- Requires the element and all of its ancestors (except body) to have *name* attributes.
- Error-prone and inefficient for deeply nested elements.

**getElementById**

```js
document.getElementById("pushMe")
```

- Because an element's identifier is unique in the document, this approach is the best.

### Checkboxes & Radio Buttons
- Checkboxes & Radio Buttons have implicit arrays with the same name as the group *name*.

```HTML
<form id="topGroup">
	<input type="checkbox" name="toppings" value="olives" />	...	<input type="checkbox" name="toppings" value="chillis" />
</form>
```

```js
var numChecked = 0;var dom = document.getElementById("topGroup");for (index = 0; index < dom.toppings.length; index++)	if (dom.toppings[index].checked)		  numChecked++;
```## Events & Event Handling
- An important JavaScript usage for web programming is to detect certain browser/user activities and provide computation when these activities occur i.e. **event-driven programming**.- An **event** is a notification that something specific has occurred.
	- e.g. the completion of loading a document
	- e.g. mouse click on a form button- An **event handler** is a script that is implicitly executed in response to the appearance of an event.
- The process of connecting an event handler to an event is called **registration**.

### Registering Event Handlers
**Assigning Script to Event Tag Attribute of HTML Element**

```HTML
<input type="button" id="myButton" onclick="alert('Clicked!');"><input type="button" id="myButton" onclick="myHandler();">```**Assigning Event Handler to JS Object**

```js
document.getElementById("myButton").onclick = myHandler;
```

- Must follow the handler function and the HTML form specification so that JavaScript has seen both before assigning the property.
- Only the name of the handler function is assigned to the property. It is neither a string nor a call to the function.**Common Tag Attributes:**

- `onblur`
- `onfocus`
- `onclick`
- `onload`
- `onmouseover`
- `onselect`
- `onchange`
- `onsubmit`

### Advantages & Limitations
- Good to keep HTML & JavaScript separate.
- Handler can be changed during use.
- Handling things like form validation on client-side saves server time and Internet time.
- However, there is no way to pass parameters to handler.