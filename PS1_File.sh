### Pointed to from .zshrc
#### Example: PS1=$( PS1_File.sh $? );


lastErrorValue=${1:-0}; # If Var $1 is not defined it's default will be 0.
function textDefault() {
# Catch exit value before any other command executes
	local _rval=$1;
 
# Get random number between 1 and 254
 	local _rndClr=$(( $RANDOM % 254 + 1 ));

# unique terminal text colour configurations
	local _hostDecor=$(tput setaf 57);
	local 	_hostClr=$(tput setaf $_rndClr ); # so host color to random number
	local _pathDecor=$(tput setaf 74);
	local 	_pathClr=$(tput setaf 15);
	local  _shellClr=$(tput setaf $(( $_rndClr + 2 ))); # set shell to random number plus two

# Home directory text with random colours for each character
	local _home=$( tput setaf $(( $RANDOM % 254 + 1 )); printf "H"; \
		       tput setaf $(( $RANDOM % 254 + 1 )); printf "o"; \
		       tput setaf $(( $RANDOM % 254 + 1 )); printf "m"; \
		       tput setaf $(( $RANDOM % 254 + 1 )); printf "e"; \
		       tput sgr0;
	 	);

# Current time in 24hr clock
	local _textTime="${BlueOnBlue}${UL}|$(date +%H:%M)|${LU}${RESET}";

# MacBook name
	local _textHost="%{${_hostDecor}${UL}${_hostClr}%}${HOSTNAME//\.*}%{${_hostDecor}${LU}${RESET}%}";

# Error text when return value isn't zero
	local _textError="%{${whiteOnRed}%}${UL}Error ${LU}%{${RESET}%}%{${redOnWhite}%}${UL} $_rval %{$LU$RESET%}";


# 'home' -OR- $PWD
	local _textPath=$([[ "$PWD" = "/Users/stephen-harold" ]] && \
		echo "%{${WHITE}%}('${_home}%{${WHITE}%}')%{${RESET}%}" || \
		echo "%{${_pathDecor}${UL}%}(%{${LU}${_pathClr}%}%2~%{${CYAN}%}/%{${_pathDecor}${UL}%})%{${LU}${RESET}%}");



# The current shell notification and insert point
	local _textShell=$( echo "%{${UL}${_shellClr}%}${SHELL//*\/}%{${LU}${RESET}${WHITE}%}:%{${RESET}%} " );


	printf "%s %s %s" "$([[ "$lastErrorValue" != 0 ]] && echo $_textError || echo $_textHost)" "$_textPath" "$_textShell";
}

# call function to print to PS1
textDefault $lastErrorValue;
