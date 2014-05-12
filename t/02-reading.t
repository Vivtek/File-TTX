#!perl -T

use Test::More tests => 18;

use File::TTX;

# Test reading of content, especially the File::TTX::Content submodule.
$ttx = File::TTX->load('t/01-test2.ttx');
isa_ok($ttx, 'File::TTX');

@content = $ttx->content_elements();

is (@content, 10);

isa_ok($content[0], 'File::TTX::Content');
isa_ok($content[0], 'XML::Snap');

is ($content[0]->type, 'open');
is ($content[0]->tag, '^');
is ($content[0]->source, '^');
is ($content[0]->translated, '^');

is ($content[1]->type, 'segment');
is ($content[1]->source, 'Abschlussfaktura');
is ($content[1]->translated, 'Final invoice');

is ($content[2]->type, 'close');

is ($content[3]->type, 'text');
is ($content[3]->source, "\n");

@segments = $ttx->segments();
is (@segments, 1);
is ($segments[0], $content[1]);

is ($segments[0]->match, 0);
$segments[0]->match (92);
is ($segments[0]->match, 92);
