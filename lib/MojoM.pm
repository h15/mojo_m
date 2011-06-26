package MojoM;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin (
        'mojo_m' => {
            driver   => 'mysql',
            database => 'gitty',
            host     => 'localhost',
            username => 'gitty',
            password => 'gitty',
        }
    );
    
    $self->model('User')->init (
        table      => 'users',
        columns    => [
            id           => { type => 'serial' , not_null => 1 },
            groups       => { type => 'text'   , not_null => 1 },
            regdate      => { type => 'integer', not_null => 1 },
            name         => { type => 'varchar', length => 32 },
            mail         => { type => 'varchar', not_null => 1, length => 64 },
            password     => { type => 'varchar', not_null => 1, default => 0, length => 32 },
            ban_reason   => { type => 'integer', not_null => 1, default => 0 },
            ban_time     => { type => 'integer', not_null => 1, default => 0 },
            confirm_key  => { type => 'varchar', not_null => 1, length => 32 },
            confirm_time => { type => 'integer', not_null => 1, length => 32 },
        ],
        pk_columns => 'id'  ,
        unique_key => 'mail',
        unique_key => 'name',
    );
    
    my $user = $self->model('User')->get( id => 1 );
    
    die $user->name;
}

1;

__END__

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011, Georgy Bazhukov.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
