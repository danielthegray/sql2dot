#!/usr/bin/perl

print "digraph ER_diagram {\n";
my $current_table;
while (<STDIN>) {
	chomp;
	if (m/CREATE TABLE ([A-Za-z0-9]*) \(/) {
		$current_table = $1;
		@fields = ();
		@references = ();
	}
	my $current_field_name;
	if (m/^\s+,?([a-zA-Z0-9]*)\s+[^\s]+/) {
		$current_field_name = $1;
		push @fields,$current_field_name;
	}
	if (m/REFERENCES ([A-Za-z0-9]+)\(([a-zA-Z0-9]+)\)/) {
		push @references, "\t$current_table:$current_field_name -> $1:$2;\n";
	}
	if (m/^\);/) {
		$table_line = "";
		$table_line .= "\t$current_table";
		$table_line .= " [shape=none,label=<<TABLE BORDER=\"1\" CELLBORDER=\"1\" CELLSPACING=\"0\">";
		$table_line .= "<TR><TD PORT=\"$current_table\"><B>$current_table</B></TD></TR>";
		for $attr (@fields) {
			$table_line .= "<TR><TD PORT=\"$attr\">$attr</TD></TR>";
			#$table_line .= " | $attr";
		} 
		$table_line .= "</TABLE>>]";
		$table_line .= "\n";
		print $table_line;
		for $ref (@references) {
			print $ref;
		}
	}
}

print "}";
