requires 'parent';
requires 'Digest::MD5';
requires 'Time::HiRes';
requires 'POSIX';
requires 'Mixin::Event::Dispatch', '>= 2.000';
requires 'Ryu', '>= 0.023';
requires 'Log::Any', '>= 1.050';
requires 'Check::UnitCheck', 0;

on 'test' => sub {
	test_requires 'Test::More', '>= 0.98';
	test_requires 'Test::Fatal', '>= 0.010';
	test_requires 'Test::Refcount', '>= 0.07';
	test_requires 'Test::HexString', '>= 0.03';
	recommends 'Log::Any::Adapter::TAP', 0;
};

on 'develop' => sub {
    requires 'HTML::TreeBuilder', 0;
    requires 'JSON::MaybeXS', 0;
};

