package DBIx::Class::JoinCondition;

use strict;
use warnings;
our $VERSION = '0.01';

{
    use DBIx::Class::ResultSet ();

    my $orig = \&DBIx::Class::ResultSet::_resolved_attrs;

    my $method = sub {
        my $self = shift;
        my $attrs = $orig->($self);

        my $on = $attrs->{on} or return $attrs;
        my $from = $attrs->{from};

        for (my $i = 1; $i < @$from; $i++) {
            my $join = $from->[$i];
            my @keys = sort keys %{$join->[0]};
            my $key  = pop(@keys);
            if (defined $on->{$key} and ref $on->{$key} eq 'HASH') {
                my $cond = $on->{$key};
                $join->[1] = {%{$join->[1]}, %$cond};
            }
        }

        return $self->{_attrs} = $attrs;
    };

    no strict 'refs';
    no warnings 'redefine';
    *{'DBIx::Class::ResultSet::_resolved_attrs'} = $method;
}

1;
__END__

=head1 NAME

DBIx::Class::JoinCondition -

=head1 SYNOPSIS

  use DBIx::Class::JoinCondition;

=head1 DESCRIPTION

DBIx::Class::JoinCondition is

=head1 AUTHOR

Ryuta Kamizono E<lt>kamipo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
