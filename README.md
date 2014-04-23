# How to use

```
	NSDictionary *dict = [NSDictionary new];
	// old way
	[[[[dict objectForKey:@"item"] objectAtIndex:6]  objectForKey:@"date"] objectForKey:"coolStuff"];

	// new way
	[dict findObject:"item(6).date.coolStuff"];
```