# piper.vim

The magic of pipes.

# Commands

There are fourteen commands by default:

| Key | Command         | Mnemonic                           |
| --- | --------------- | ---------------------------------- |
| a   | ansifilter      | (A)nsifilter                       |
| c   | column -t       | (C)olumn                           |
| d   | uniq -d         | show only (D)uplicate lines        |
| e   | uniq -c         | (E)numerate (count) the duplicates |
| f   | clang-format    | (F)ormat source code               |
| k   | sort -t: -k1,1  | Sort file by (K)ey                 |
| l   | nl -nrz -w4 -ba | (L)ine numbers                     |
| n   | sort -n         | (N)umeric sort                     |
| r   | rev             | (R)everse each                     |
| s   | sort -f         | (S)ort lines (fold case)           |
| t   | tac             | (T)ac (reverse the file)           |
| u   | uniq            | (U)nique (remove duplicate lines)  |
| x   | shuf            | mi(X) up lines                     |
| z   | cat -s          | squee(Z)e blank lines              |

# Mappings

First, it's a good idea to create a mapping to show the mappings.
This will list all the shortcuts and the commands they call:

    nmap <silent> <F6> <Plug>PiperShowMappings

Alternatively, you can

    :call PiperShowMappings()

Each command has three mappings.
Each mapping begins with cp (remember this as Change using a Pipe),
followed by a letter from the table above.
For example, the mappings for the "rev" command are:

| Mapping | Description                                      |
| ------- | ------------------------------------------------ |
| cpr     | Filter region defined by vim {motion} commands   |
| cprr    | Filter the current line                          |
| cpR     | Filter the entire file (note the capital letter) |

e.g.

| Mapping       | Works on      | Command         | Effect                              |
| ------------- | ------------- | --------------- | ----------------------------------- |
| cpa\{motion\} | \{motion\}    | ansifilter      | ANSI sequences are stripped out     |
| cpaa          | current line  | ansifilter      | ANSI sequences are stripped out     |
| cpA           | entire file   | ansifilter      | ANSI sequences are stripped out     |
| cpc\{motion\} | \{motion\}    | column -t       | Data are put into columns           |
| cpcc          | current line  | column -t       | Data are put into columns           |
| cpC           | entire file   | column -t       | Data are put into columns           |
| cpd\{motion\} | \{motion\}    | uniq -d         | Only duplicate lines are shown      |
| cpdd          | current line  | uniq -d         | Only duplicate lines are shown      |
| cpD           | entire file   | uniq -d         | Only duplicate lines are shown      |
| cpe\{motion\} | \{motion\}    | uniq -c         | Duplicate lines are counted         |
| cpee          | current line  | uniq -c         | Duplicate lines are counted         |
| cpE           | entire file   | uniq -c         | Duplicate lines are counted         |
| cpf\{motion\} | \{motion\}    | clang-format    | Source lines are tidied             |
| cpff          | current line  | clang-format    | Source lines are tidied             |
| cpF           | entire file   | clang-format    | Source lines are tidied             |
| cpk\{motion\} | \{motion\}    | sort -t: -k1,1  | Lines are sorted by key             |
| cpkk          | current line  | sort -t: -k1,1  | Lines are sorted by key             |
| cpK           | entire file   | sort -t: -k1,1  | Lines are sorted by key             |
| cpl\{motion\} | \{motion\}    | nl -nrz -w4 -ba | Lines are numbered                  |
| cpll          | current line  | nl -nrz -w4 -ba | Lines are numbered                  |
| cpL           | entire file   | nl -nrz -w4 -ba | Lines are numbered                  |
| cpn\{motion\} | \{motion\}    | sort -n         | Lines are sorted numerically        |
| cpnn          | current line  | sort -n         | Lines are sorted numerically        |
| cpN           | entire file   | sort -n         | Lines are sorted numerically        |
| cpr\{motion\} | \{motion\}    | rev             | Each line is written backwards      |
| cprr          | current line  | rev             | Each line is written backwards      |
| cpR           | entire file   | rev             | Each line is written backwards      |
| cps\{motion\} | \{motion\}    | sort -f         | Lines are sorted (ignoring case)    |
| cpss          | current line  | sort -f         | Lines are sorted (ignoring case)    |
| cpS           | entire file   | sort -f         | Lines are sorted (ignoring case)    |
| cpt\{motion\} | \{motion\}    | tac             | Lines are written in reverse order  |
| cptt          | current line  | tac             | Lines are written in reverse order  |
| cpT           | entire file   | tac             | Lines are written in reverse order  |
| cpu\{motion\} | \{motion\}    | uniq            | Duplicate lines are removed         |
| cpuu          | current line  | uniq            | Duplicate lines are removed         |
| cpU           | entire file   | uniq            | Duplicate lines are removed         |
| cpx\{motion\} | \{motion\}    | shuf            | Lines are written in a random order |
| cpxx          | current line  | shuf            | Lines are written in a random order |
| cpX           | entire file   | shuf            | Lines are written in a random order |
| cpz\{motion\} | \{motion\}    | cat -s          | Duplicate blank lines are removed   |
| cpzz          | current line  | cat -s          | Duplicate blank lines are removed   |
| cpZ           | entire file   | cat -s          | Duplicate blank lines are removed   |

# Configuration

The pipes are initialised from a vim dictionary.  Here's the default:

    let g:piper_command_list = {
        \ 'a': 'LANG=C ansifilter',
        \ 'c': 'LANG=C column --table --output-separator " "',
        \ 'd': 'LANG=C uniq --repeated',
        \ 'e': 'LANG=C uniq --count',
        \ 'f': 'LANG=C clang-format -assume-filename=%',
        \ 'k': 'LANG=C sort --field-separator=: --key=1,1 --key=2,2n --key=3,3n',
        \ 'l': 'LANG=C nl --number-format=rz --number-width=4',
        \ 'n': 'LANG=C sort --numeric-sort',
        \ 'r': 'LANG=C rev',
        \ 's': 'LANG=C sort --ignore-case',
        \ 't': 'LANG=C tac',
        \ 'u': 'LANG=C uniq',
        \ 'x': 'LANG=C shuf',
        \ 'z': 'LANG=C cat --squeeze-blank',
    \ }

To add your own command, or change the parameters for an existing command,
copy the script, above, into your `.vimrc`.

## Examples

| Type This | Result                               |
| --------- | ------------------------------------ |
| cpsip     | Current paragraph is sorted          |
| cpx9j     | Ten lines are randomised             |
| cpL       | Add lines numbers to the entire file |

## License

Copyright &copy; Richard Russon (flatcap).
Distributed under the GPLv3 <http://fsf.org/>

## See also

- [flatcap.org](https://flatcap.org)
- [GitHub](https://github.com/flatcap/vim-piper)

