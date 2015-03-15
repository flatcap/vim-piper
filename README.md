# vim-piper.vim

vim-piper: The magic of pipes.

# Commands

There are eight commands by default:

| Key | Command       | Description            |
| --- | ------------- | ---------------------- |
| c   | column -t     | Put data into columns  |
| m   | sort -n       | Numeric sort           |
| n   | nl -nrz -w4   | Number lines           |
| r   | rev           | Reverse each line      |
| s   | sort -f       | Sort (fold case)       |
| t   | tac           | Reverse the file       |
| u   | uniq          | Remove duplicate lines |
| x   | shuf          | Randomise the file     |

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

| Mapping     | Description                                                   |
| -------     | ------------------------------------------------------------- |
| cpc{motion} | Run text within {motion} through the "column" command.        |
| cpcc        | Run current line through the  "column" command.               |
| cpC         | Run the "column" command on the entire file.                  |
| cpm{motion} | Run text within {motion} through the "sort -n" command.       |
| cpmm        | Run current line through the  "sort -n" command.              |
| cpM         | Run the "sort -n" command on the entire file.                 |
| cpn{motion} | Run text within {motion} through the "nl" command.            |
| cpnn        | Run current line through the  "nl" command.                   |
| cpN         | Run the "nl" command on the entire file.                      |
| cpr{motion} | Run text within {motion} through the "rev" command.           |
| cprr        | Run current line through the  "rev" command.                  |
| cpR         | Run the "rev" command on the entire file.                     |
| cps{motion} | Run text within {motion} through the "sort" command.          |
| cpss        | Run current line through the  "sort" command.                 |
| cpS         | Run the "sort" command on the entire file.                    |
| cpt{motion} | Run text within {motion} through the "tac" command.           |
| cptt        | Run current line through the  "tac" command.                  |
| cpT         | Run the "tac" command on the entire file.                     |
| cpu{motion} | Run text within {motion} through the "uniq" command.          |
| cpuu        | Run current line through the  "uniq" command.                 |
| cpU         | Run the "uniq" command on the entire file.                    |
| cpx{motion} | Run text within {motion} through the "shuf" (random) command. |
| cpxx        | Run current line through the  "shuf" command.                 |
| cpX         | Run the "shuf" command on the entire file.                    |

# Configuration

The pipes are initialised from a vim dictionary.  Here's the default:

    let g:piper_commands = {
        \ 'c': 'LANG=C column -t',
        \ 'm': 'LANG=C sort -n',
        \ 'n': 'LANG=C nl -nrz -w4',
        \ 'r': 'LANG=C rev',
        \ 's': 'LANG=C sort -f',
        \ 't': 'LANG=C tac',
        \ 'u': 'LANG=C uniq',
        \ 'x': 'LANG=C shuf',
    \ }

To add your own command, or change the parameters for an existing command,
copy the script, above, into your .vimrc (before the call to pathogen).

## Examples

| Type This | Result                               |
| --------- | ------------------------------------ |
| cpsip     | Current paragraph is sorted          |
| cpx9j     | Ten lines are randomised             |
| cpN       | Add lines numbers to the entire file |

## License

Copyright (c) Richard Russon (flatcap).
Distributed under the same terms as Vim itself.
See `:help license`.

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-piper)

