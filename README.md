# vim-piper.vim

vim-piper: The magic of pipes.

# Commands

There are nine commands by default:

| Key | Command       | Description                       |
| --- | ------------- | --------------------------------- |
| c   | column -t     | put data into (C)olumns           |
| l   | nl -nrz -w4   | (L)ine numbers                    |
| n   | sort -n       | (N)umeric sort                    |
| r   | rev           | (R)everse each line               |
| s   | sort -f       | (S)ort lines (fold case)          |
| t   | tac           | (T)ac (reverse the file)          |
| u   | uniq          | (U)nique (remove duplicate lines) |
| x   | shuf          | mi(X) up the file                 |
| z   | cat -s        | squee(Z)e blank lines             |

# Mappings

Each command has three mappings.
Each mapping begins with cp (remember this as Change using a Pipe), followed by a letter from the table above.
For example, the mappings for the "rev" command are:

| Mapping | Description                                      |
| ------- | ------------------------------------------------ |
| cpr     | Filter region defined by vim {motion} commands   |
| cprr    | Filter the current line                          |
| cpR     | Filter the entire file (note the capital letter) |

e.g.

| Mapping     | Description                                              |
| ----------- | -------------------------------------------------------- |
| cpc{motion} | Run text within {motion} through the "column -t" command |
| cpcc        | Run current line through the  "column -t" command        |
| cpC         | Run the "column -t" command on the entire file           |
| cpl{motion} | Run text within {motion} through the "nl" command        |
| cpll        | Run current line through the  "nl" command               |
| cpL         | Run the "nl" command on the entire file                  |
| cpn{motion} | Run text within {motion} through the "sort -n" command   |
| cpnn        | Run current line through the  "sort -n" command          |
| cpN         | Run the "sort -n" command on the entire file             |
| cpr{motion} | Run text within {motion} through the "rev" command       |
| cprr        | Run current line through the  "rev" command              |
| cpR         | Run the "rev" command on the entire file                 |
| cps{motion} | Run text within {motion} through the "sort -f" command   |
| cpss        | Run current line through the  "sort -f" command          |
| cpS         | Run the "sort -f" command on the entire file             |
| cpt{motion} | Run text within {motion} through the "tac" command       |
| cptt        | Run current line through the  "tac" command              |
| cpT         | Run the "tac" command on the entire file                 |
| cpu{motion} | Run text within {motion} through the "uniq" command      |
| cpuu        | Run current line through the  "uniq" command             |
| cpU         | Run the "uniq" command on the entire file                |
| cpx{motion} | Run text within {motion} through the "shuf" command      |
| cpxx        | Run current line through the  "shuf" command             |
| cpX         | Run the "shuf" command on the entire file                |
| cpz{motion} | Run text within {motion} through the "cat -s" command    |
| cpzz        | Run current line through the  "cat -s" command           |
| cpZ         | Run the "cat -s" command on the entire file              |

# Configuration

The pipes are initialised from a vim dictionary.  Here's the default:

    let g:piper_command_list = {
	    \ 'c': 'LANG=C column -t',
	    \ 'l': 'LANG=C nl -nrz -w4',
	    \ 'n': 'LANG=C sort -n',
	    \ 'r': 'LANG=C rev',
	    \ 's': 'LANG=C sort -f',
	    \ 't': 'LANG=C tac',
	    \ 'u': 'LANG=C uniq',
	    \ 'x': 'LANG=C shuf',
	    \ 'z': 'LANG=C cat -s',
    \ }

To add your own command, or change the parameters for an existing command,
copy the script, above, into your .vimrc (before the call to pathogen).

## Examples

| Type This | Result                               |
| --------- | ------------------------------------ |
| cpsip     | Current paragraph is sorted          |
| cpx9j     | Ten lines are randomised             |
| cpL       | Add lines numbers to the entire file |

## License

Copyright (c) Richard Russon (flatcap).
Distributed under the same terms as Vim itself.
See `:help license`.

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-piper)

