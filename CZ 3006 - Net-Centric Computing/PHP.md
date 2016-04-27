# PHP

## Basics
- Server-side scripting language.
- Scripts are embedded in HTML documents.

```php
<?php
	...
?>
```

## General Syntax
- Comments: `//`, `#`, `/* ... */`
- Every variable name begins with a `$`. No type declarations.
- An unassigned variable has the value NULL.
	- The `unset` function sets a variable to NULL.
	- The `IsSet` function determines whether a variable is NULL.

## Primitives, Operations & Expressions
- Primitive Types:
	- Scalar Types: Boolean, Integer, Double & String
	- Compound Types: Array

### Strings
- String literals use `'` or `"`.
- `'` - Embedded variables are not interpolated.
- `"` - Embedded variables are interpolated.

```php
$val = 5;
$string = "It takes $val";	// It takes 5
$string = 'It takes $val';	// It takes $val
```

### Arithmetic Operators & Expressions
- Usual operators.
- If the result of an integer division is not an integer, a double is returned.
- Any integer operation that results in an overflow returns a double.
- The modulus operator - `%` - coerces its operands to integer, if necessary.
- When a double is rounded to an integer, the rounding is always towards zero.

### Some Arithmetic Functions
- `floor(x)`
- `ceil(x)`
- `round(x)`
- `abs(x)`
- `min(x, y, z)`
- `max(x, y, z)`
- `rand()` or `rand(x, y)`

### String Operations & Functions
- The only operator is `.`, for concatenation.
- Indexing: `$str{3}`
- `strlen($str)` - Returns the length of the string.
- `strcmp($str, $str)` - Returns 0 if the two strings are same.
- `strpos($haystack, $needle)` - Returns the position of the first occurrence of a substring in a string.
- `substr($str, $start [, $end])` - Returns the a part of the string from the $start index.
- `trim($str)` - Removes whitespace from both ends.
- `chop($str)` - Removes whitespace from the right end.
- `ltrim($str)` - Removes whitespace from the left end.
- `strtolower($str)`, `strtoupper($str)`

### Scalar Type Conversions
- Explicit Conversions or Casts
	- e.g. `(int)$total` or `settype($total, "integer")`
- String to Numeric
	- If the string contains an `e` or an `E`, it is converted to a double, otherwise, integer.
	- If the string does not begin with a sign or a digit, zero is used.
- The type of the variable can be returned by:
	- `gettype($total)`
	- `is_integer($total)`

## Control Statements
```php
if (control expression) {
	// statement(s)
} else if (control expression) {
	// statement(s)
} else {
	// statement(s)
}

switch (expression) {
	case val1:
		// statement(s)
	case val2:
		// statement(s)
	default:
		// statement(s)
}

while (control expression) {
	// statement(s)
}

do {
	// statement(s)
} while (control expression)

for (init expression; control expression; increment expression) {
	// statement(s)
}
```
```php
break;
continue;
```

### Control Expressions
- Same as JavaScript, including `===` and `!==`.

## Arrays
- A PHP array is a generalisation of the arrays of other languages.
	- A mapping of keys to values.
	- The keys can be numbers or strings.
	- The value can be anything.

### Creating Arrays
```php
$list = array(0 => "apples", 1 => "oranges");
$list = array("make" => "Boeing", "model" => "747");
$list = array(1, 2, 3, 4, 5);
```

- If a key is omitted and there have been integer keys, the default key will be the largest current key + 1.
- If a key is omitted and there have been no integer keys, 0 is the default key.
- If a key appears twice, the new value will overwrite the old one.

### Accessing Arrays
```php
$list[4] = 7;
$list["day"] = 8;
```

- If an element with the specified key does not exist, it is created.- If the array does not exist, the array is created.

### Deleting Arrays
```php
unset($list);
unset($list[4]);
```

### Extracting the Keys
```php
$array = array(0 => 100, "color" => "red");
array_keys($array);	// (0 => 0, 1 => "color")
```

### Useful Functions
```php
is_array($list);
in_array(17, $list);
sizeof($list);
explode(" ", $str);		// creates an array split on " "
implode(",", $list);	// creates a string of elements separated by ","
```

### foreach
```php
foreach ($list as $listelement) { ... }

foreach ($list as $listkey => $listelement) { ... }
```

## User Defined Functions
```php
function funcName(parameters) { ... }
```
- Functions need not be defined before they are called.
- Function overloading is not supported.
- Functions cannot be redefined.
- Functions can have a variable number of parameters.
- Function definitions can be nested.

### Parameters
- If the caller sends too many actual parameters, the subprogram ignores the extra ones.
- If the caller does not send enough parameters, the unmatched formal parameters are unbound.
- The default parameter passing method is pass by value (one-way communication).- To specify pass-by-reference, an ampersand has to prepended to the parameter name.

```php
function funcName(&$param1, $param2) { ... }
```

### Return Values
- Any type may be returned, including objects and arrays.
- If a function returns a reference, the name of the function must have a prepended ampersand.

```php
function &funcName() { ... }
```

## Pattern Matching
- Similar to JavaScript.

```php
preg_match(regex, str [, array]);
preg_match_all(regex, str [, array]);
preg_match("/^PHP/", $str);
```

- The optional array is where to put the matches, if any.
- `preg_match()` returns the number of times the pattern matches. This will be either 0 or 1 because `preg_match()` will stop searching after the first match.
- `preg_match_all()` will continue until it reaches the end of `$str`.

## Output
- The output from a PHP script is an HTML document that is sent to the browser.
- The PHP processor has two modes: **Copy** (HTML) & **Interpret** (PHP).

```HTML
<html>	<head><title>PHP Example</title></head>	<body>		<?php			print "Welcome to my Web site!";		?>	</body></html>
```- HTML is produced through standard output &mdash; `print` or `printf`.

```php
print "<p>This is a paragraph.</p>";
printf("There are %d humans.", $num);
```

## Form Handling
- PHP builds an array of the form values.
- `$_POST` for the POST method. Keys are the widget *names*.
- `$_GET` for the GET method. Keys are the parameter names.

## Files
- PHP can deal with any files on the server or on the Internet, using either *http* or *ftp*.
- A file has a file pointer, which specifies where to read and write.

```php
$filename = '/path/to/file.txt';
$fptr = fopen($filename, "<mode>") or exit("Unable to open $filename.");
fclose($fptr);
```
```php
file_exists($filename); // returns boolean
```

**Modes:**

- `r`: Read-Only. Place pointer at beginning of file.
- `r+`: Read & Write. Place pointer at beginning of file.
- `w`: Write-Only. Place pointer at beginning of file and truncate the entire file to zero length. If the file does not exist, create it.
- `w+`: Read & Write. Place pointer at beginning of file and truncate the entire file to zero length. If the file does not exist, create it.
- `a`: Write-Only. Place pointer at the end of the file. If the file does not exist, create it.
- `a+`: Read & Write. Place pointer at the end of the file. If the file does not exist, create it.

### Reading Files
```php
$str = fread($fptr, $num_bytes);
$str = fread($fptr, filesize($filename));

$line = fgets($fptr [, $num_bytes]);

$ch = fgetc($fptr);

while (!feof($fptr)) { ... }

$lines_arr = file($filename); // no need to open/close
```

### Writing to Files
```php
$bytes_written = fwrite($fptr, $str);
```

### Truncating Files
```php
$ftruncate($fptr);
```

### Locking Files
- Files can be locked to avoid interference from concurrent accesses with `flock`.
	- `LOCK_SH` to acquire a shared lock (reader).
	- `LOCK_EX` to acquire an exclusive lock (writer).
	- `LOCK_UN` to release a lock.

```php
$fp = fopen("/tmp/lock.txt", "r+");if (flock($fp, LOCK_EX)) { // obtain an exclusive lock	ftruncate($fp, 0); // truncate file	fwrite($fp, "Write something here.\n");	flock($fp, LOCK_UN); // release the lock} else {	echo "Couldn't get the lock!";}
fclose($fp);
```

## Cookies
- HTTP protocol is stateless, however, there are several reasons why a server may find it useful to relate a request to earlier requests.
- A **cookie** is a name-value pair that is passed between a browser and a server in the HTTP header.
- In PHP, cookies are created with `setcookie`.

```php
/* setcookie(cookie_name, cookie_value, lifetime in secs) */

setcookie("cookie1", "one", time() + 86400);
```

- Cookies are implicitly deleted when their lifetimes are over.
- Cookies must be created before any HTML is created by the script.
- Cookies are obtained in a script the same way as form values &mdash; `$_COOKIE` array.

**HTTP Response Header**

```
HTTP/1.1 200 OK
...
Set-Cookie: ...
...
```

**HTTP Request Headers (after cookies are set)**

```
GET /spec.php HTTP/1.1
...
Cookie: name=value; name2=value2
...
```

## Session Tracking
- A **session** is the time span during which a browser interacts with a particular server.- In order to track sessions, PHP creates and maintains a session tracking ID.
- `session_start()` to create the ID.
- `session_register()` to register session variables.
- Subsequent calls to `session_start()` retrieves any session variables that were previously registered.

```php
/* Counting Page Visits */
session_start();if (!IsSet($page_number))		$page_number = 1;$page_number++;session_register("page_number");```

### How to Implement Sessions?
- Option 1: The session tracking ID can be stored as a cookie on the client's computer.

```
Set-Cookie: JSESSIONID=3E4897823HKJHDKS978KDJ
```

- Option 2: The action URLs for forms can be rewritten to include the session tracking ID as a GET parameter.

```HTML
<form name="form" method="post" action="login.php?jsessionid=3E4897823HKJHDKS978KDJ>
```