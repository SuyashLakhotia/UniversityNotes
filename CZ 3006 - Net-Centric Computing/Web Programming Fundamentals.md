# Web Programming Fundamentals

## Basics
- **The Internet** is a world-wide network of computer networks.
	- At the lowest level, all connections use TCP/IP.
	- Every node has a unique numeric address i.e. IP Address.
- **The Web** is a collection of software and protocols on the Internet (e.g. HTTP, TELNET, FTP).
- **Client-Server Programming** involves clients requesting resources from a server through a browser and servers responding with requested resources.
- **Domain Names** are textual names of computers on the Internet.
	- The fully qualified domain name is the host name and all the domain names.
	- DNS Servers convert fully qualified domain names to IP addresses.
- **Unformed Resource Locators (URLs)** are addresses to specific resources.
	- General Form: `scheme:object-address`
		- The `scheme` is often a communication protocol like http, telnet, ftp etc.
	- URLs cannot include spaces or any of a collection of other special characters (semicolons, colons etc.).
	- If the doc-path ends with a `/`, it's a directory.
- **Web Servers** provide responses to browser requests.
	- Responses can be existing documents or dynamically built documents.
	- Web servers run as background processes in the operating system, monitoring a communication port.

## HTTP (Hyper Text Transfer Protocol)

### HTTP Request
#### General Form:

```
HTTP-Method URL HTTP-Version
Header Fields
Blank Line
Message Body (Optional)
```
```
GET /pub/WWW/TheProject.html HTTP/1.1
```

#### Commonly Used Methods:

- **`GET`:** Fetch a document.
- **`POST`:** Execute the document using the data in body (now mainly used for form data processing).
- **`HEAD`:** Fetch the header of the document.
- **`PUT`:** Store a new document on the server.
- **`DELETE`:** Remove a document from the server.

#### Common Request Header Fields:
- `Accept: text/plain` &mdash; Specify browser's preference for the MIME type of the requested document.
- `If-Modified-Since: date` &mdash; Send the requested document only if it has been modified since the given date.
- `Content-Length: <number of bytes>` (for POST request)
- `Content-Type: text/html` (for POST request)

##### Some Type Specifications
- `text/plain`
- `text/html`
- `text/*`
- `image/gif`
- `image/jpeg`

### HTTP Response
#### General Form:
```
Status Line
Response Header Fields
Blank Line
Response Body (Optional)
```

#### Status Line Format:
```
HTTP-Version Status-Code Explanation
```

- The status code is a three digit number.
- Examples:
	- `HTTP/1.1 200 OK`
	- `HTTP/1.1 100 Continue`
	- `HTTP/1.1 400 Bad Request`
	- `HTTP/1.1 403 Forbidden`
	- `HTTP/1.1 404 Not Found`
	- `HTTP/1.1 500 Internal Server Error`

## Web Programmer's Toolbox
- **HTML & XHTML**
	- To describe the general form and layout of documents.	- An HTML document is a mixture of content and controls.		- Controls are specified by tags and their attributes.	- XHTML is nothing more than HTML with stronger syntactic rules.- **JavaScript**
	- A client-side HTML-embedded scripting language.	- Provides a way to access elements of HTML documents and dynamically change them.
- **PHP**
	- A server-side scripting language.
	- Similar to JavaScript.
	- Great for form processing and database access through the Web.
- **Flash, AJAX, .NET...**