package DBIx::Class::Schema::Critic::PolicyType;

use strict;
use utf8;
use Modern::Perl;

our $VERSION = '0.014';    # VERSION
require Devel::Symdump;
use List::MoreUtils;
use Moo::Role;
use Sub::Quote;
use namespace::autoclean -also => qr{\A _}xms;
with 'DBIx::Class::Schema::Critic::Policy';

has applies_to => (
    is   => 'ro',
    lazy => 1,
    ## no critic (ValuesAndExpressions::RequireInterpolationOfMetachars)
    default => quote_sub( <<'END_SUB' => { '$package' => \__PACKAGE__ } ),
        [   List::MoreUtils::apply {s/\A .+ :://xms}
            grep { shift->does($_) } Devel::Symdump->packages($package),
        ];
END_SUB
);

1;

# ABSTRACT: Role for types of database criticism policies

__END__

=pod

=for :stopwords Mark Gardner cpan testmatrix url annocpan anno bugtracker rt cpants
kwalitee diff irc mailto metadata placeholders

=encoding utf8

=head1 NAME

DBIx::Class::Schema::Critic::PolicyType - Role for types of database criticism policies

=head1 VERSION

version 0.014

=head1 SYNOPSIS

    package DBIx::Class::Schema::Critic::PolicyType::ResultClass;
    use Moo;
    with 'DBIx::Class::Schema::Critic::PolicyType';
    1;

=head1 DESCRIPTION

This is a L<role|Moo::Role> consumed by all
L<DBIx::Class::Schema::Critic|DBIx::Class::Schema::Critic> policy types.

=head1 ATTRIBUTES

=head2 applies_to

Returns an array reference containing the last component of all the
C<DBIx::Class::Schema::Critic::PolicyType>
roles composed into the consuming class.

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc DBIx::Class::Schema::Critic

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/DBIx-Class-Schema-Critic>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annonations of Perl module documentation.

L<http://annocpan.org/dist/DBIx-Class-Schema-Critic>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/DBIx-Class-Schema-Critic>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.perl.org/dist/overview/DBIx-Class-Schema-Critic>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/D/DBIx-Class-Schema-Critic>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual way to determine what Perls/platforms PASSed for a distribution.

L<http://matrix.cpantesters.org/?dist=DBIx-Class-Schema-Critic>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=DBIx::Class::Schema::Critic>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the web
interface at L<https://github.com/mjgardner/DBIx-Class-Schema-Critic/issues>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/mjgardner/DBIx-Class-Schema-Critic>

  git clone git://github.com/mjgardner/DBIx-Class-Schema-Critic.git

=head1 AUTHOR

Mark Gardner <mjgardner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Mark Gardner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
