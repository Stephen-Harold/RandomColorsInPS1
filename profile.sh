## Add this to your profile file in your home directory
## The file must be executable in order to have it return a value to PS1

# set custom prompt options
setopt PROMPT_PERCENT           # % treated special
setopt PROMPT_SUBST             # parameter expansion & command substitution are performed in prompts
setopt PROMPT_SP PROMPT_CR      # SP: \r at end of partial line, CP: \r before prompt

## for zsh shell you must define the hook precmd
function precmd() {
    local _exitValue=$?;
    local _filePS1="~/.PS1_File.sh";
    # have a fall back prompt if file is missing
    [[ -r "$_filePS1" ]] && PS1=$( "$_filePS1" "$_exitValue" || PS1="[%n@%M] (%2~)$: ")
}
