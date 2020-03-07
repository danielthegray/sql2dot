# sql2dot
A short hacky Perl script to generate a DOT file out of an SQL table creation script.

## Usage
The script reads the SQL from `stdin` and outputs the `dot` script to `stdout`.

Example:

    ./sql2dot.pl < table_defs.sql > table_graph.dot

You can than use any `dot` implementation (like GraphViz) to output the graph to your preferred format (PS, SVG, PNG, etc.)
For example:

    dot -O -Tpng table_graph.dot

## Explanation
The script simply finds `CREATE TABLE ` entries, and saves up the column names until it finds a `);`. It also parses **inline** `REFERENCES` statements to other tables, (like `userId BIGINT REFERENCES User(id)`) and creates a link between those 2 items in the graph. I have not fiddled much with the arrows (feel free to contribute!).

The SQL is parsed like this because it is the way my hand-written SQL file was (and most others I write). I don't like using tools that generate the SQL because I find it too verbose for my liking. I didn't see value in parsing the code that such tools generate as your starting point is a diagram anyway.

Feel free to report issues you face (which I will only address _if I have time_) or to contribute fixes/patches!
