# Filta
### "Search for data based on tags, rather than keys".

Written by darmantinjr / darmyn
Written on: September 28th, 2021 around 11PM -> September 29th, 2021 at 2:00 AM. (I know I'm slow)

Why filta?
Filta makes it easy to store data under tags. This allows you to make more precise searches.

MAKE YOUR OWN SEARCH METHODS: Filta comes built in with some search methods. These are global search methods
inside of the "searchMethods" table inside of `Filta.lua`. You can add search methods to this table to create global search methods
that are accessible by all filta objects. You can also write custom search methods that are exclusive to
one filta objects using :NewSearchMethod() on a filta object.

SET DEFAULT SEARCH METHOD: You can change the global default search method for all filta objects below. You can set a 
default search method to a specific filter object as well by modifying the `DefaultSearchMethod` property of a filta object.
This might save you typing time if a filta object is using the same search method more than others.
