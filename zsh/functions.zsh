# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_"
}

# Change directory and list contents
function cd() {
    builtin cd "$@" && ls -la
}

# Extract most know archives with one command
function extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find files by name
function ff() {
    find . -type f -name "*$1*"
}

# Find directories by name
function fd() {
    find . -type d -name "*$1*"
}

# Git commit with message
function gcm() {
    git commit -m "$*"
}

# Create a .tar.gz archive
function targz() {
    tar -czf "${1}.tar.gz" "${1}"
}

# Get the weather
function weather() {
    curl "wttr.in/${1:-}"
}

# Quick look at files (macOS)
function ql() {
    qlmanage -p "$*" >& /dev/null
}

# Show all the names (CNs and SANs) listed in the SSL certificate
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        return 1
    fi

    local domain="${1}"
    echo "Testing ${domain}…"
    echo ""

    local tmp
    tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
        | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText
        certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version")
        echo "Common Name:"
        echo ""
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\\/emailAddress=.*//"
        echo ""
        echo "Subject Alternative Name(s):"
        echo ""
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
        return 0
    else
        echo "ERROR: Certificate not found."
        return 1
    fi
}