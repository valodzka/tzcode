# @(#)Makefile	7.46

# Change the line below for your time zone (after finding the zone you want in
# the time zone files, or adding it to a time zone file).
# Alternately, if you discover you've got the wrong time zone, you can just
#	zic -l rightzone
# to correct things.
# Use the command
#	make zonenames
# to get a list of the values you can use for LOCALTIME.

LOCALTIME=	Factory

# If you want something other than Eastern United States time as a template
# for handling POSIX-style time zone environment variables,
# change the line below (after finding the zone you want in the
# time zone files, or adding it to a time zone file).
# (When a POSIX-style environment variable is handled, the rules in the
# template file are used to determine "spring forward" and "fall back" days and
# times; the environment variable itself specifies GMT offsets of standard and
# summer time.)
# Alternately, if you discover you've got the wrong time zone, you can just
#	zic -p rightzone
# to correct things.
# Use the command
#	make zonenames
# to get a list of the values you can use for POSIXRULES.
# If you want POSIX compatibility, use "America/New_York".

POSIXRULES=	America/New_York

# Everything gets put in subdirectories of. . .

TOPDIR=		/usr/local

# "Compiled" time zone information is placed in the "TZDIR" directory
# (and subdirectories).
# Use an absolute path name for TZDIR unless you're just testing the software.

TZDIR=		$(TOPDIR)/etc/zoneinfo

# The "zic" and "zdump" commands get installed in. . .

ETCDIR=		$(TOPDIR)/etc

# If you "make INSTALL", the "date" command gets installed in. . .

BINDIR=		$(TOPDIR)/bin

# Manual pages go in subdirectories of. . .

MANDIR=		$(TOPDIR)/man

# Library functions are put in an archive in LIBDIR.

LIBDIR=		$(TOPDIR)/lib
TZLIB=		$(LIBDIR)/libz.a

# If you always want time values interpreted as "seconds since the epoch
# (not counting leap seconds)", use
#	REDO=		posix_only
# below.  If you always want right time values interpreted as "seconds since
# the epoch" (counting leap seconds)", use
#	REDO=		right_only
# below.  If you want both sets of data available, with leap seconds not
# counted normally, use
#	REDO=		posix_right
# below.  If you want both sets of data available, with leap seconds counted
# normally, use
#	REDO=		right_posix
# below.
# POSIX mandates that leap seconds not be counted; for compatibility with it,
# use either "posix_only" or "posix_right".

REDO=		posix_right

# Since "." may not be in PATH...

YEARISTYPE=	./yearistype

# Add the following to the end of the "CFLAGS=" line as needed.
#  -DHAVE_ADJTIME=0 if `adjtime' does not exist (SVR0?)
#  -DHAVE_LONG_DOUBLE=1 if your compiler supports the `long double' type
#  -DHAVE_SETTIMEOFDAY=0 if settimeofday does not exist (SVR0?)
#  -DHAVE_SETTIMEOFDAY=1 if settimeofday has just 1 arg (SVR4)
#  -DHAVE_SETTIMEOFDAY=2 if settimeofday uses 2nd arg (4.3BSD)
#  -DHAVE_SETTIMEOFDAY=3 if settimeofday ignores 2nd arg (4.4BSD)
#  -DLOCALE_HOME=\"path\" if locales are in "path", not "/usr/lib/locale"
#  -DHAVE_UNISTD_H=0 if your compiler lacks a "unistd.h" (Microsoft C++ 7?)
#  -DHAVE_UTMPX_H=1 if your compiler has a "utmpx.h"
#  $(GCC_DEBUG_FLAGS) if you are using GCC and want lots of checking
#
GCC_DEBUG_FLAGS = -Dlint -g -O -fno-common \
	-Wall -Wcast-qual -Wconversion -Wmissing-prototypes \
	-Wnested-externs -Wpointer-arith -Wshadow \
	-Wtraditional # -Wstrict-prototypes -Wwrite-strings
#
# If you want to use System V compatibility code, add
#	-DUSG_COMPAT
# to the end of the "CFLAGS=" line.  This arrange for "timezone" and "daylight"
# variables to be kept up-to-date by the time conversion functions.  Neither
# "timezone" nor "daylight" is described in X3J11's work.
#
# If your system has a "GMT offset" field in its "struct tm"s
# (or if you decide to add such a field in your system's "time.h" file),
# add the name to a define such as
#	-DTM_GMTOFF=tm_gmtoff
# or
#	-DTM_GMTOFF=_tm_gmtoff
# to the end of the "CFLAGS=" line.
# Neither tm_gmtoff nor _tm_gmtoff is described in X3J11's work;
# in its work, use of "tm_gmtoff" is described as non-conforming.
# Both UCB and Sun have done the equivalent of defining TM_GMTOFF in
# their recent releases.
#
# If your system has a "zone abbreviation" field in its "struct tm"s
# (or if you decide to add such a field in your system's "time.h" file),
# add the name to a define such as
#	-DTM_ZONE=tm_zone
# or
#	-DTM_ZONE=_tm_zone
# to the end of the "CFLAGS=" line.
# Neither tm_zone nor _tm_zone is described in X3J11's work;
# in its work, use of "tm_zone" is described as non-conforming.
# Both UCB and Sun have done the equivalent of defining TM_ZONE in
# their recent releases.
#
# If you want functions that were inspired by early versions of X3J11's work,
# add
#	-DSTD_INSPIRED
# to the end of the "CFLAGS=" line.  This arranges for the functions
# "tzsetwall", "offtime", "timelocal", "timegm", "timeoff",
# "posix2time", and "time2posix" to be added to the time conversion library.
# "tzsetwall" is like "tzset" except that it arranges for local wall clock
# time (rather than the time specified in the TZ environment variable)
# to be used.
# "offtime" is like "gmtime" except that it accepts a second (long) argument
# that gives an offset to add to the time_t when converting it.
# "timelocal" is equivalent to "mktime".
# "timegm" is like "timelocal" except that it turns a struct tm into
# a time_t using GMT (rather than local time as "timelocal" does).
# "timeoff" is like "timegm" except that it accepts a second (long) argument
# that gives an offset to use when converting to a time_t.
# "posix2time" and "time2posix" are described in an included manual page.
# None of these functions are described in X3J11's current work.
# Sun has provided "tzsetwall", "timelocal", and "timegm" in SunOS 4.0.
# These functions may well disappear in future releases of the time
# conversion package.
#
# If you want Source Code Control System ID's left out of object modules, add
#	-DNOID
# to the end of the "CFLAGS=" line.
#
# If you'll never want to handle solar-time-based time zones, add
#	-DNOSOLAR
# to the end of the "CFLAGS=" line
# (and comment out the "SDATA=" line below).
# This reduces (slightly) the run-time data-space requirements of
# the time conversion functions; it may reduce the acceptability of your system
# to folks in oil- and cash-rich places.
#
# If you want to allocate state structures in localtime, add
#	-DALL_STATE
# to the end of the "CFLAGS=" line.  Storage is obtained by calling malloc.
#
# If you want an "altzone" variable (a la System V Release 3.1), add
#	-DALTZONE
# to the end of the "CFLAGS=" line.
# This variable is not described in X3J11's work.
#
# If you want a "gtime" function (a la MACH), add
#	-DCMUCS
# to the end of the "CFLAGS=" line
# This function is not described in X3J11's work.
#
# NIST-PCTS:151-2, Version 1.4, (1993-12-03) is a test suite put
# out by the National Institute of Standards and Technology
# which claims to test C and Posix conformance.  If you want to pass PCTS, add
#	-DPCTS
# to the end of the "CFLAGS=" line.
#
# If you want strict compliance with XPG4 as of April 9, 1994, add
#	-DXPG4_1994_04_09
# to the end of the "CFLAGS=" line.  This causes "strftime" to always return
# 53 as a week number (rather than 52 or 53) for those days in January that
# before the first Monday in January when a "%V" format is used and January 1
# falls on a Friday, Saturday, or Sunday.

CFLAGS=

###############################################################################

cc=		cc
CC=		$(cc) -DTZDIR=\"$(TZDIR)\"

TZCSRCS=	zic.c localtime.c asctime.c scheck.c ialloc.c
TZCOBJS=	zic.o localtime.o asctime.o scheck.o ialloc.o
TZDSRCS=	zdump.c localtime.c asctime.c ialloc.c
TZDOBJS=	zdump.o localtime.o asctime.o ialloc.o
DATESRCS=	date.c localtime.c logwtmp.c strftime.c asctime.c
DATEOBJS=	date.o localtime.o logwtmp.o strftime.o asctime.o
LIBSRCS=	localtime.c asctime.c difftime.c
LIBOBJS=	localtime.o asctime.o difftime.o
HEADERS=	tzfile.h private.h
NONLIBSRCS=	zic.c zdump.c scheck.c ialloc.c
NEWUCBSRCS=	date.c logwtmp.c strftime.c
SOURCES=	$(HEADERS) $(LIBSRCS) $(NONLIBSRCS) $(NEWUCBSRCS)
MANS=		newctime.3 newstrftime.3 newtzset.3 time2posix.3 \
			tzfile.5 zic.8 zdump.8
DOCS=		README Theory $(MANS) date.1 Makefile
YDATA=		africa antarctica asia australasia \
		europe northamerica southamerica pacificnew etcetera factory \
		backward
NDATA=		systemv
SDATA=		solar87 solar88 solar89
TDATA=		$(YDATA) $(NDATA) $(SDATA)
DATA=		$(YDATA) $(NDATA) $(SDATA) leapseconds yearistype.sh
MISC=		usno1988 usno1989 usno1989a usno1995 Music WWW
ENCHILADA=	$(DOCS) $(SOURCES) $(DATA) $(MISC)

# And for the benefit of csh users on systems that assume the user
# shell should be used to handle commands in Makefiles. . .

SHELL=		/bin/sh

all:		zic zdump $(LIBOBJS)

ALL:		all date

install:	all $(DATA) $(REDO) $(TZLIB) $(MANS)
		./zic -y $(YEARISTYPE) \
			-d $(TZDIR) -l $(LOCALTIME) -p $(POSIXRULES)
		-mkdir $(TOPDIR) $(ETCDIR)
		cp zic zdump $(ETCDIR)/.
		-mkdir $(TOPDIR) $(MANDIR) \
			$(MANDIR)/man3 $(MANDIR)/man5 $(MANDIR)/man8
		-rm -f $(MANDIR)/man3/newctime.3 \
			$(MANDIR)/man3/newtzset.3 \
			$(MANDIR)/man5/tzfile.5 \
			$(MANDIR)/man8/zdump.8 \
			$(MANDIR)/man8/zic.8
		cp newctime.3 newtzset.3 $(MANDIR)/man3/.
		cp tzfile.5 $(MANDIR)/man5/.
		cp zdump.8 zic.8 $(MANDIR)/man8/.

INSTALL:	ALL install date.1
		-mkdir $(TOPDIR) $(BINDIR)
		cp date $(BINDIR)/.
		-mkdir $(TOPDIR) $(MANDIR) $(MANDIR)/man1
		-rm -f $(MANDIR)/man1/date.1
		cp date.1 $(MANDIR)/man1/.

zdump:		$(TZDOBJS)
		$(CC) $(CFLAGS) $(LFLAGS) $(TZDOBJS) -o $@

zic:		$(TZCOBJS) yearistype
		$(CC) $(CFLAGS) $(LFLAGS) $(TZCOBJS) -o $@

yearistype:	yearistype.sh
		cp yearistype.sh yearistype
		chmod +x yearistype

posix_only:	zic $(TDATA)
		./zic -y $(YEARISTYPE) -d $(TZDIR) -L /dev/null $(TDATA)

right_only:	zic leapseconds $(TDATA)
		./zic -y $(YEARISTYPE) -d $(TZDIR) -L leapseconds $(TDATA)

other_two:	zic leapseconds $(TDATA)
		./zic -y $(YEARISTYPE) -d $(TZDIR)/posix -L /dev/null $(TDATA)
		./zic -y $(YEARISTYPE) \
			-d $(TZDIR)/right -L leapseconds $(TDATA)

posix_right:	posix_only other_two

right_posix:	right_only other_two

$(TZLIB):	$(LIBOBJS)
		-mkdir $(TOPDIR) $(LIBDIR)
		ar ru $@ $(LIBOBJS)
		if [ -x /usr/ucb/ranlib -o -x /usr/bin/ranlib ] ; \
			then ranlib $@ ; fi

# We use the system's logwtmp in preference to ours if available.

date:		$(DATEOBJS)
		ar r ,lib.a logwtmp.o
		if [ -x /usr/ucb/ranlib -o -x /usr/bin/ranlib ] ; \
			then ranlib ,lib.a ; fi
		$(CC) $(CFLAGS) date.o localtime.o asctime.o strftime.o \
			-lc ,lib.a -o $@
		rm -f ,lib.a

clean:
		rm -f core *.o *.out zdump zic yearistype date ,* *.tar.gz

names:
		@echo $(ENCHILADA)

public:		$(ENCHILADA)
		tar cf - $(DOCS) $(SOURCES) $(MISC) | gzip -9 > tzcode.tar.gz
		tar cf - $(DATA) | gzip -9 > tzdata.tar.gz

zonenames:	$(TDATA)
		@awk '/^Zone/ { print $$2 } /^Link/ { print $$3 }' $(TDATA)

asctime.o:	private.h tzfile.h
date.o:		private.h
difftime.o:	private.h
ialloc.o:	private.h
localtime.o:	private.h tzfile.h
scheck.o:	private.h
strftime.o:	tzfile.h
zic.o:		private.h tzfile.h

.KEEP_STATE:
