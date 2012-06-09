#!/usr/bin/perl --
#
#
# Requires:
#	Config::Simple
#
#
# New BSD License
#
# Copyright (c) 2012  Hiroaki Abe <hiroaki0404@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.


use strict;
use FileHandle;
use IPC::Open2;
use POSIX qw(SIGALRM);
use Config::Simple;
use Sys::Syslog;
use File::Basename qw(dirname basename);

chdir(dirname($0));
my $cfg = new Config::Simple($ENV{"HOME"}."/.keepvpn");
if ($cfg == '') {
    system("./settings &");
    die "No setting file found.\n";
}
my %Config = $cfg->vars();
if (! $Config{'default.setting'} ||
    ! $Config{'default.host'} ||
    ! $Config{'default.interval'}) {
    system("./settings &");
    die "Setting file is broken.\n";
}

my $pid = open2(*Reader, *Writer, "scutil");

POSIX::sigaction(SIGALRM,
		 POSIX::SigAction->new(sub { print Writer "n.cancel\n" }))
    or die "Error setting SIGALRM handler: $!\n";

print Writer "n.add State:/Network/Interface\n";
print Writer "n.watch\n";

openlog(basename($0), 'cons,pid', 'local0');
close STDOUT;
open STDOUT, '/dev/console';
close STDERR;
open STDERR, ">&", *STDOUT;

system("./keepvpn.sh &");

while(<Reader>) {
    sleep(5);
    system("./keepvpn.sh -once");
    syslog('info', "Connect to $Config{'default.setting'}");
}
print Writer "n.cancel\n";
close Writer;
close Reader;
closelog();

__END__
