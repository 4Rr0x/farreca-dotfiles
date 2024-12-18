source <(fzf --zsh)

if ! systemctl status docker | grep running &> /dev/null; then
		echo "[Francinette] Starting Docker..."
		sleep 1
		exec "/bin/bash"
fi
if ! docker image ls | grep francinette-image &> /dev/null; then
		echo "[Francinette] Loading the docker container"
		docker load < /home/arrox/francinette-image/francinette.tar
		exec "/bin/bash"
fi
if ! docker ps | grep "francinette-image" &> /dev/null; then
	if docker run -d -i -v /home:/home -v /goinfre:/goinfre -v /sgoinfre:/sgoinfre -v /home/arrox/francinette-image/logs:/francinette/logs-t --name run-paco francinette-image /bin/bash 2>&1 | grep "already" &> /dev/null; then
		docker start run-paco
	fi
fi
alias francinette=/home/arrox/francinette-image/run.sh

alias paco=/home/arrox/francinette-image/run.sh
