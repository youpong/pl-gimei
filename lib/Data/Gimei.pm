package Data::Gimei;

our $VERSION = '0.01';

=encoding utf-8

=head1 NAME

Data::Gimei - a Perl port of Ruby's gimei.

=head1 SYNOPSIS

  use Data::Gimei;

  my $gimei = Data::Gimei::Name->new();

                                    # an example
  print $gimei->kanji;              # "斎藤陽菜"
  print $gimei->hiragana;           # "さいとうはるな"
  print $gimei->katakana;           # "サイトウハルナ"

  print $gimei->last_name->kanji;   # "斎藤"
  print $gimei->first_name->kanji;  # "陽菜"

=head1 DESCRIPTION

This module generates fake data that people's name in Japanese and
supports furigana, phonetic renderings of kanji.

The project name comes from Japanese '偽名' means a false name.

=head1 LICENSE

Copyright (C) NAKAJIMA Yusaku.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

NAKAJIMA Yusaku E<lt> example@example.com E<gt>

=cut

use strict;
use warnings;
use English;
use utf8;

use feature ':5.30';

package Data::Gimei::Name;

our $names;

use File::Share ':all';
use YAML;

use Moo;
has gender     => ( is => 'rw' );
has first_name => ( is => 'rw' );
has last_name  => ( is => 'rw' );

sub sample {
    my $array = shift;
    my $len = @$array;
    return $array->[rand($len)];
}

sub BUILD {
    my $self = shift;

    $names //= load();
    my $fn = sample( $names->{'first_name'}->{'male'} );
    $self->first_name( Data::Gimei::Word->new( $fn ) );
    my $ln = sample( $names->{'last_name'} );
    $self->last_name(  Data::Gimei::Word->new( $ln ) );
}

sub load {
    my $yaml_path = shift // dist_file('Data-Gimei', 'names.yml');

    $names = YAML::LoadFile($yaml_path);
}

sub kanji {
    my $self = shift;
    return $self->last_name()->kanji . " " . $self->first_name()->kanji;
}

sub hiragana {
    my $self = shift;
    return $self->last_name()->hiragana . " " . $self->first_name()->hiragana;
}

sub katakana {
    my $self = shift;
    return $self->last_name()->katakana . " " . $self->first_name()->katakana;
}

package Data::Gimei::Word;
use Moo;
has kanji    => ( is => 'rw' ); # TODO: ro
has hiragana => ( is => 'rw' ); # TODO: ro
has katakana => ( is => 'rw' ); # TODO: ro

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( 'ARRAY' eq ref $_[0] ) {
        return $class->$orig( kanji    => $_[0]->[0],
                              hiragana => $_[0]->[1],
                              katakana => $_[0]->[2] );
    } else {
        return $class->$orig(@_);
    }
};

1;
