use inc::Module::Install;
name 'DBIx-Class-JoinCondition';
all_from 'lib/DBIx/Class/JoinCondition.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
