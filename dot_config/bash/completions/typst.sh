_typst() {
    local i cur prev opts cmd
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="typst"
                ;;
            typst,c)
                cmd="typst__compile"
                ;;
            typst,compile)
                cmd="typst__compile"
                ;;
            typst,completions)
                cmd="typst__completions"
                ;;
            typst,fonts)
                cmd="typst__fonts"
                ;;
            typst,help)
                cmd="typst__help"
                ;;
            typst,info)
                cmd="typst__info"
                ;;
            typst,init)
                cmd="typst__init"
                ;;
            typst,query)
                cmd="typst__query"
                ;;
            typst,update)
                cmd="typst__update"
                ;;
            typst,w)
                cmd="typst__watch"
                ;;
            typst,watch)
                cmd="typst__watch"
                ;;
            typst__help,compile)
                cmd="typst__help__compile"
                ;;
            typst__help,completions)
                cmd="typst__help__completions"
                ;;
            typst__help,fonts)
                cmd="typst__help__fonts"
                ;;
            typst__help,help)
                cmd="typst__help__help"
                ;;
            typst__help,info)
                cmd="typst__help__info"
                ;;
            typst__help,init)
                cmd="typst__help__init"
                ;;
            typst__help,query)
                cmd="typst__help__query"
                ;;
            typst__help,update)
                cmd="typst__help__update"
                ;;
            typst__help,watch)
                cmd="typst__help__watch"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        typst)
            opts="-h -V --color --cert --help --version compile c watch w init query fonts update completions info help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --cert)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__compile)
            opts="-f -j -h --format --root --input --font-path --ignore-system-fonts --ignore-embedded-fonts --package-path --package-cache-path --creation-timestamp --pages --pdf-standard --no-pdf-tags --ppi --make-deps --deps --deps-format --jobs --features --diagnostic-format --open --timings --help <INPUT> [OUTPUT]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --format)
                    COMPREPLY=($(compgen -W "pdf png svg html" -- "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -W "pdf png svg html" -- "${cur}"))
                    return 0
                    ;;
                --root)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --input)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --font-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-cache-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --creation-timestamp)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pages)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pdf-standard)
                    COMPREPLY=($(compgen -W "1.4 1.5 1.6 1.7 2.0 a-1b a-1a a-2b a-2u a-2a a-3b a-3u a-3a a-4 a-4f a-4e ua-1" -- "${cur}"))
                    return 0
                    ;;
                --ppi)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --make-deps)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --deps)
                    local oldifs
                    if [ -n "${IFS+x}" ]; then
                        oldifs="$IFS"
                    fi
                    IFS=$'\n'
                    COMPREPLY=($(compgen -f "${cur}"))
                    if [ -n "${oldifs+x}" ]; then
                        IFS="$oldifs"
                    fi
                    if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
                        compopt -o filenames
                    fi
                    return 0
                    ;;
                --deps-format)
                    COMPREPLY=($(compgen -W "json zero make" -- "${cur}"))
                    return 0
                    ;;
                --jobs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -j)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --features)
                    COMPREPLY=($(compgen -W "html a11y-extras" -- "${cur}"))
                    return 0
                    ;;
                --diagnostic-format)
                    COMPREPLY=($(compgen -W "human short" -- "${cur}"))
                    return 0
                    ;;
                --open)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --timings)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__completions)
            opts="-h --help bash elvish fish powershell zsh"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__fonts)
            opts="-h --font-path --ignore-system-fonts --ignore-embedded-fonts --variants --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --font-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help)
            opts="compile watch init query fonts update completions info help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__compile)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__completions)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__fonts)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__help)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__info)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__init)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__query)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__update)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__help__watch)
            opts=""
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__info)
            opts="-f -h --format --pretty --help"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --format)
                    COMPREPLY=($(compgen -W "json yaml" -- "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -W "json yaml" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__init)
            opts="-h --package-path --package-cache-path --help <TEMPLATE> [DIR]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --package-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-cache-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__query)
            opts="-j -h --field --one --format --pretty --target --root --input --font-path --ignore-system-fonts --ignore-embedded-fonts --package-path --package-cache-path --creation-timestamp --jobs --features --diagnostic-format --help <INPUT> <SELECTOR>"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --field)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --format)
                    COMPREPLY=($(compgen -W "json yaml" -- "${cur}"))
                    return 0
                    ;;
                --target)
                    COMPREPLY=($(compgen -W "paged html" -- "${cur}"))
                    return 0
                    ;;
                --root)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --input)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --font-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-cache-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --creation-timestamp)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --jobs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -j)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --features)
                    COMPREPLY=($(compgen -W "html a11y-extras" -- "${cur}"))
                    return 0
                    ;;
                --diagnostic-format)
                    COMPREPLY=($(compgen -W "human short" -- "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__update)
            opts="-h --force --revert --backup-path --help [VERSION]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --backup-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        typst__watch)
            opts="-f -j -h --format --root --input --font-path --ignore-system-fonts --ignore-embedded-fonts --package-path --package-cache-path --creation-timestamp --pages --pdf-standard --no-pdf-tags --ppi --make-deps --deps --deps-format --jobs --features --diagnostic-format --open --timings --no-serve --no-reload --port --help <INPUT> [OUTPUT]"
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                --format)
                    COMPREPLY=($(compgen -W "pdf png svg html" -- "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -W "pdf png svg html" -- "${cur}"))
                    return 0
                    ;;
                --root)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --input)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --font-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --package-cache-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --creation-timestamp)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pages)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --pdf-standard)
                    COMPREPLY=($(compgen -W "1.4 1.5 1.6 1.7 2.0 a-1b a-1a a-2b a-2u a-2a a-3b a-3u a-3a a-4 a-4f a-4e ua-1" -- "${cur}"))
                    return 0
                    ;;
                --ppi)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --make-deps)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --deps)
                    local oldifs
                    if [ -n "${IFS+x}" ]; then
                        oldifs="$IFS"
                    fi
                    IFS=$'\n'
                    COMPREPLY=($(compgen -f "${cur}"))
                    if [ -n "${oldifs+x}" ]; then
                        IFS="$oldifs"
                    fi
                    if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
                        compopt -o filenames
                    fi
                    return 0
                    ;;
                --deps-format)
                    COMPREPLY=($(compgen -W "json zero make" -- "${cur}"))
                    return 0
                    ;;
                --jobs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -j)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --features)
                    COMPREPLY=($(compgen -W "html a11y-extras" -- "${cur}"))
                    return 0
                    ;;
                --diagnostic-format)
                    COMPREPLY=($(compgen -W "human short" -- "${cur}"))
                    return 0
                    ;;
                --open)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --timings)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --port)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
    complete -F _typst -o nosort -o bashdefault -o default typst
else
    complete -F _typst -o bashdefault -o default typst
fi
