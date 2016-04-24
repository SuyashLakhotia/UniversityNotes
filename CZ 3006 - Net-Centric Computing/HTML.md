# HTML

## Basics
- **Tag:** `<name>`
	- **Opening Tag:** `<name>`
	- **Closing Tag:** `</name>`
- The opening tag & closing tag together specify a **container** for the **content**.
- **Container + Content = Element**
- Tags can have **attributes** to specify alternative meanings.
	- `<name attr="value">`
- **Comments:** `<!-- ... -->`

## Important Tags
```HTML
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Hello, world</title>
	</head>
	
	<body>
		...
	</body>
</html>
```
```HTML
<p></p>
<br/>
<h1></h1> ... <h6></h6>
```
```HTML
<b>Bold</b>
<i>Italics</i>
<big>Larger</big>
<small>Smaller</small>
<tt>Monospace</tt>
<sub>Subscript</sub>
<sup>Superscript</sup>
```
```HTML
<img src="URL" width="200" height="200" />
```
```HTML
<a href="target"></a>
```
```HTML
<ul>
	<li></li>
	<li></li>
</ul>

<ol>
	<li></li>
	<li></li>
</ol>
```
```HTML
<table>
	<tr>
		<th align="center" valign="center"></th>
		<th align="left" valign="top"></th>
		<th align="right" valign="bottom"></th>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td></td>
	</tr>
</table>
```
```
<form action="">
	<input type="text" name="" size="30" maxlength="20" />
	
	<textarea name="" rows="4" cols="10" />
	
	<input type="checkbox" name="g1" value="v1" checked="checked"/>
	<input type="checkbox" name="g1" value="v2" />
	<input type="checkbox" name="g1" value="v3" />
	<input type="checkbox" name="g1" value="v4" />
	
	<input type="radio" name="g2" value="v1" />
	<input type="radio" name="g2" value="v2" />
	<input type="radio" name="g2" value="v3" />
	<input type="radio" name="g2" value="v4" />
	
	<select name="">
		<option></option>
		<option></option>
		<option></option>
	</select>
	
	<input type="reset" value="Reset Form" />
	<input type="submit" value="Submit Form" />
</form>
```