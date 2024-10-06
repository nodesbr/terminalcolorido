# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

clear

echo "Bem vindo!"
echo ""
echo " => Para obter ajudar digite: tutor."
echo ""

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    prompt_symbol=🤗️🐧
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
        prompt_color='\[\033[;94m\]'
        info_color='\[\033[1;31m\]'
        prompt_symbol=😡️
    fi
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u${prompt_symbol}\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
        oneline)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
        backtrack)
            PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
    esac
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="PROMPT_COMMAND=echo"

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

#==============================================
# Aliases para uso no dia-a-dia e testes
#==============================================

# Testar conexão com ping
alias pingoogle="ping -t 3 www.google.com"
# Pingar o Google a cada 3 segundos
alias pingyoutube="ping -t 3 youtube.com"
# Pingar o YouTube a cada 3 segundos

alias rastrear2="tracerout google.com" 
# Rastrear rota até o Google.com
alias rastrear="mtr google.com" 
# Rastrear rota até o Google.com

#=============================================#
# Aliases para uso do nodes2016/2024          =
#=============================================#
   #= faz um update =#
alias update="echo Realizando um UPDATE padrão... && sudo apt-get update && echo Pronto."
   #= faz um update sem erros =#
alias update2="echo Realizando um UPDATE sem erros... && sudo apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && echo Pronto, mano."

   #= faz um upgrade =#
alias upgrade="echo Um UPGRADE será feito... && sudo apt-get upgrade"
   #= faz um full-upgrade =#
alias atualizar-tudo="echo FULL-UPGRADE não recomendado... && read && sudo apt-get update && sudo apt-get full-upgrade && echo Meu Deus, espero mesmo que tenha funcioando para você."

   #= faz um update e um upgrade =#
alias atualizar="echo Primeiro um UPDATE... && sudo apt-get update && echo Agora um UPGRADE... && sudo apt-get upgrade -y && echo Sistema atualizado com sucesso."
   #= faz um update sem erro e um upgrade =#
alias atualizar2="echo Primeiro um UPDATE ignorando os ERROS... && sudo apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && echo E agora um UPGRADE-y... && sudo apt-get upgrade -y && echo Sistema atualizado com sucesso, mas ignorando os erros"

   #= faz um update e um dist-upgrade =#
alias atualizar-distro="echo DIST-UPGRADE não recomendado... && read && sudo apt-get update && sudo apt-get dist-upgrade && echo Meu Deus, espero mesmo que tenha funcioando para você."

   #= instala um programa =#
alias instalar="echo Vamos instalar um programa... && sudo apt-get install"
   #= remover um programa =#
alias remover="echo Quer mesmo remover esse programa? && sudo apt-get remove"
   #= remover completamente um programa =#
alias arrancar="echo Removendo com um ---PURGE REMOVE. Cuidado! && sudo apt-get --purge remove"
   #= Reinstalar um programa =#
alias reinstalar="echo Comando de reinstalação de programas. && sudo apt-get install --reinstall"

   #= Editar sources.list do sistema =#
alias lista="echo abrindo SOURCES.LIST... && sudo xed /etc/apt/sources.list"
   #= Reparar o dpkg =#
alias reparar-dpkg="echo Configurando o DPKG com defeito... && sudo dpkg --configure -a && echo E ai, deu certo?"
   #= Reparar instalação =#
alias reparar-instalacao="echo Tentando reparar com um INSTALL-F... && sudo apt-get install -f && echo E ai, deu certo?"
   #= limpa o cache de programas baixados e instalados =#
alias limpar-cache="echo Removendo instaladores baixados e inuteis... && sudo apt-get clean && echo Tudo Limpo."
alias autoremover="echo autoremovendo pacotes inuteis de programas... && sudo apt-get autoremove && echo Removidos com sucesso."

# REMOVER BILBLIOTECAS E DEPENDÊNCIAS ORFÃS#
alias remover-orfas="echo = Remover biliotecas orfãs? Ctrl+C para cancelar. && read && sudo deborphan | xargs sudo apt-get -y remove --purge"
alias remover-orfas2="echo = Remover dados de biliotecas orfãs? Ctrl+C para cancelar. && read && sudo deborphan --guess-data | xargs sudo apt-get -y remove --purge"

# COMO TROCAR DONO DE UMA PASTA #
alias trocardono="echo = Para trocar o dono da pasta use: sudo chown -R userX:userX /home/userX"

alias swap="echo = Ver se a Prioridade atual é = a 60. && echo cat /proc/sys/vm/swappiness && echo && echo Definir temporariamente a 10. && echo sudo sysctl vm.swappiness=10 && echo && echo Prioridade 10 Definitiva. && echo sudo gedit /etc/sysctl.conf && echo && echo Adicione a linha no final. && echo vm.swappiness=10"

alias hora="echo horast= status, horautc= Horario universal, horarg= regiões disponiveis, horacv= Cape_Verde."
alias horast="timedatectl status"
alias horautc="timedatectl set-timezone UTC"
alias horarg="timedatectl list-timezones |  egrep  -o "America/N.*""
alias horacv="timedatectl set-timezone "Atlantic/Cape_Verde""

# - comando variados - #
alias internet="ifconfig"
alias usuario="whoami"
alias abrir="cd"
alias voltar="cd .."
alias ver="ls"
alias ver-tudo="ls -la"
alias limpar="clear"
alias ajuda="help"
alias sistema="neofetch"
alias tutor="cat ~/.tutor"

## zipar pasta do conkymanager##
alias zip-conky="zip -r NDS2016-ThemePack.cmtp.7z conkyzipado"
alias zipar="zip -r Arquivo.zipado.zip"

## SCAN DE REDE NMPA##
alias scanrede="nmap -sP 192.168.31.0/24"
alias scanmaquinas="sudo nmap -sS -O -T3 -oA invent 192.168.31.0/24"

## Detener NetworkManager
alias pararede="sudo service NetworkManager stop"

## Iniciar NetworkManager
alias iniciarede="sudo service NetworkManager start"

## Reiniciar NetworkManager
alias reiniciarede="sudo service NetworkManager restart"

## Stop Modo Monitor
alias pararmodomonitor="sudo airmon-ng stop wlan0mon"

## Start Modo Monitor
alias iniciarmodomonitor="sudo airmon-ng start wlan"

alias subfinder="cd ~/go/bin/ && echo Buscando Subdominios... && ./subfinder -d "
 
#reseta o usuario a padrao###########
alias resetar-usuario="echo Limpar usuário? Ctrl+C para cancelar. && read && mkdir ~/DocSalvos && cp -f -r .* ~/DocSalvos && rm -rf .*"

alias matar="killall"
alias matador="echo Clique em um programa aberto. && xkill"

alias fechar="exit"
alias reiniciar="echo O PC será reiniciado em 10s. && sleep 10 && echo Pressione Ctrl+C para Cancelar && sudo halt"
#=============================================#
# - Final dos Alias do Nodes de Atualização - #
#=============================================#

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
