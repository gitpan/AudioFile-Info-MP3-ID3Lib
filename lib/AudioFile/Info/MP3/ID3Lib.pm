package AudioFile::Info::MP3::ID3Lib;

use 5.006;
use strict;
use warnings;
use Carp;

use MP3::ID3Lib;

our $VERSION = sprintf "%d.%02d", '$Revision: 1.3 $ ' =~ /(\d+)\.(\d+)/;

my %data = (artist => 'TPE1',
            title  => 'TIT2',
            album  => 'TALB',
            track  => 'TRCK',
            year   => 'TYER',
            genre  => 'TCON');

sub new {
  my $class = shift;
  my $file = shift;
  my $obj = MP3::ID3Lib->new($file);

  bless { obj => $obj }, $class;
}

sub DESTROY {}

sub AUTOLOAD {
  our $AUTOLOAD;

  my ($pkg, $sub) = $AUTOLOAD =~ /(.+)::(\w+)/;

  die "Invalid attribute $sub" unless exists $data{$sub};

  if ($_[1]) {
    my $attr = $_[1];
    my $found;
    for (@{$_[0]->{obj}->frames}) {
      if($_->code eq $data{$sub}) {
	$found = 1;
	$_->set($attr);
      }
    }

    $_[0]->{obj}->add_frame($data{$sub}, $_[1]) unless $found;
    $_[0]->{obj}->commit;
  }

  for (@{$_[0]->{obj}->frames}) {
    return $_->value if $_->code eq $data{$sub};
  }
}


1;
__END__

=head1 NAME

AudioFile::Info::MP3::ID3Lib - Perl extension to get info from MP3 files.

=head1 DESCRIPTION

This is a plugin for AudioFile::Info which uses MP3::ID3Lib to get
data about MP files.

See L<AudioFile::Info> for more details.

=head1 AUTHOR

Dave Cross, E<lt>dave@dave.org.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Dave Cross

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut