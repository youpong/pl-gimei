package Data::Gimei;

use 5.010;
use strict;
use warnings;

use version; our $VERSION = version->declare("v0.4.3");

use Data::Gimei::Name;
use Data::Gimei::Address;
use Data::Gimei::Word;
use Data::Gimei::Random;

my $r = Data::Gimei::Random->new;

sub set_random_seed {
    my $seed = shift;
    $r->set_seed($seed);
}

sub sample {
    my $array = shift;
    return $r->sample($array);
}
1;

__END__

=encoding utf-8

=head1 NAME

Data::Gimei - A Perl module ported from Ruby's gimei that randomly generates
Japanese names and addresses.

=head1 SYNOPSIS

  use 5.010;
  use strict;
  use warnings;

  binmode STDOUT, ":utf8";

  use Data::Gimei;
  my $name = Data::Gimei::Name->new();
                                   # for example
  say $name->kanji;                # "斎藤 陽菜"
  say $name->hiragana;             # "さいとう はるな"
  say $name->katakana;             # "サイトウ ハルナ"
  say $name->romaji;               # "Haruna Saito"

  say $name->surname->kanji;       # "斎藤"
  say $name->surname->hiragana;    # "さいとう"
  say $name->surname->katakana;    # "サイトウ"
  say $name->surname->romaji;      # "Saito"

  say $name->forename->kanji;      # "陽菜"
  say $name->forename->hiragana;   # "はるな"
  say $name->forename->katakana;   # "ハルナ"
  say $name->forename->romaji;     # "Haruna"

  say $name->gender;               # "female"

  my $addr = Data::Gimei::Address->new();
  say $addr->kanji;                # "北海道札幌市中央区モエレ沼公園"
  say $addr->hiragana;             # "ほっかいどうさっぽろしちゅうおうくもえれぬまこうえん"
  say $addr->katakana;             # "ホッカイドウサッポロシチュウオウクモエレヌマコウエン"

  say $addr->prefecture->kanji;    # "北海道"
  say $addr->prefecture->hiragana; # "ほっかいどう"
  say $addr->prefecture->katakana; # "ホッカイドウ"

  say $addr->city->kanji;          # "札幌市中央区"
  say $addr->city->hiragana;       # "さっぽろしちゅうおうく"
  say $addr->city->katakana;       # "サッポロシチュウオウク"

  say $addr->town->kanji;          # "モエレ沼公園"
  say $addr->town->hiragana;       # "もえれぬまこうえん"
  say $addr->town->katakana;       # "モエレヌマコウエン"

=head1 DESCRIPTION

Data::Gimei generates fake Japanese names and addresses. 
Generated names include a first name, a last name, and their associated gender.
Names are available in kanji, hiragana, katakana, and romanized forms, where
hiragana, katakana, and romanized forms are phonetic renderings for kanji. 
Addresses include a prefecture, city, and town, and can be generated in kanji,
hiragana or katakana. The output format can be customized using specific options.
Note that the gender notation cannot be changed.

The project name comes from Japanese '偽名' means a false name.

=head2 Deterministic Random

Data::Gimei supports seeding of its pseudo-random number generator to provide deterministic
output of repeated method calls.

  Data::Gimei::set_random_seed(42);
  my $name = Data::Gimei::Name->new();
  $name->kanji;                    # "村瀬 零"
  $address = Data::Gimei::Address->new();
  $address->kanji;                 # "沖縄県那覇市祝子町"

  Data::Gimei::set_random_seed(42);
  my $name = Data::Gimei::Name->new();
  $name->kanji;                    # "村瀬 零"
  rand;                            # Do not change result by calling rand()
  $address = Data::Gimei::Address->new();
  $address->kanji;                 # "沖縄県那覇市祝子町"

=head1 INSTALL

This module is available on CPAN.  You can install this module
by following the step below.

  $ cpanm Data::Gimei

=head1 DOCUMENTATION

After installing, you can find documentation for this module with the
perldoc command.

  $ perldoc Data::Gimei

You can also look for information at:

  GitHub Repository (report bugs here)
      https://github.com/youpong/Data-Gimei

  Search CPAN
      https://metacpan.org/dist/Data-Gimei

=head1 SEE ALSO

=over 4

=item *

L<App::Gimei>

A command-line tool for this module.

=back

=head1 LICENSE

MIT License

Dictionary YAML file is generated from naist-jdic.

=head1 AUTHOR

NAKAJIMA Yusaku E<lt> youpong@cpan.org E<gt>

=cut
