FROM ubuntu:20.04

ENV USER user
RUN useradd $USER

COPY target /home/$USER/target

RUN chown -R root:$USER /home/$USER
RUN chmod -R 555 /home/$USER
RUN apt-get update
RUN apt-get install -y xinetd gdbserver
COPY target.xinetd /etc/xinetd.d/$USER

# port for target binary
EXPOSE 1337

# port for optional gdb server (had to be run manually)
EXPOSE 1338

CMD service xinetd start && sleep 2 && tail -f /var/log/xinetdlog
