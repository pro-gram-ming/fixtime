#!/usr/bin/perl -lanF\t

use POSIX qw/ceil/;

# Minimum, maximum, and increment (minutes)
$min = 5;
$max = 47;
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

# Backtrack from extent
sub btr {
  ($m, $m2) = @_;

  until ($m2 - $m > $min && $m2 - $m < $max) {
    $m2 -= $inc;
  }

  return $m2;
}

BEGIN {
  @x = ();
}

print;

$day = shift @F;

@i = map { h2m() } @F;

if ($. > 1) {
  foreach $n (0..$#F) {
    $i[$n] = btr($i[$n], $x[$n]);
  }
} else {
  # Load extent data
  @x = map { fwd(h2m()) } @F;
}

print join "\t", ($day, map { m2h($_) . " " x 3 } @i);
print "\n";
