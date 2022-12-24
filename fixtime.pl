#!/usr/bin/perl -lanF\t

use POSIX qw/ceil/;

# Minimum, maximum, and increment (minutes)
$min = 5;
$max = 15;
$inc = 15;

# Convert e.g. "12:03 PM" to raw minutes
sub h2m {
  /^ *(\d\d):(\d\d) (AM|PM) *$/;
  ($h, $m) = ($1, $2);

  $h %= 12;

  $h * 60 + $m + ($3 eq "PM" ? 12 * 60 : 0);
}

# Convert raw minutes to e.g. "15:24"
sub m2h {
  ($m) = @_;
  sprintf "%02d:%02d", $m / 60, $m % 60;
}

# Move time forward to next increment
sub fwd {
  ($m) = @_;

  $m2 = ceil($m / $inc) * $inc;

  until ($m2 - $m > $min) {
    $m2 += $inc;
  }

  return $m2;
}

print;

$day = shift @F;
@inc_list = ($day);

foreach (@F) {
  push @inc_list, m2h(fwd(h2m())) . " " x 3;
}

print join "\t", @inc_list;
print "\n";
