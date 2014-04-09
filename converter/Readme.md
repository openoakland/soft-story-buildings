requires the [spreadsheet](https://github.com/zdavatz/spreadsheet) gem

```sh
ruby convert.rb file.xls > output.json
```

#### data structure

```js
{
	"keys": ["Property Address", "Mailing Address", "City & State", "Postal Code", "Category"]
	"rows": [
		["Row 0 Property Address", "Row 1 Mailing Address", ...]
		...
	]
}
```
