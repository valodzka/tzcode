#ifndef lint
#ifndef NOID
static char	elsieid[] = "@(#)optind.c	7.2";
#endif /* !defined NOID */
#endif /* !defined lint */

int	opterr = 1,		/* if error message should be printed */
	optind = 1;		/* index into parent argv vector */
char	*optarg;		/* argument associated with option */
